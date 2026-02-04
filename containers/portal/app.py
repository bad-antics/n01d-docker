#!/usr/bin/env python3
"""
n01d-portal - Unified Docker Container Dashboard
bad-antics | Local container management
"""

from flask import Flask, render_template, jsonify, request
from flask_socketio import SocketIO, emit
import docker
import os

app = Flask(__name__)
app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY', 'n01d-portal-secret')
socketio = SocketIO(app, cors_allowed_origins="*")

client = docker.from_env()

# Container definitions with metadata
CONTAINERS = {
    'n01d-pentest': {'icon': '🔴', 'name': 'Pentest', 'desc': 'Kali penetration testing', 'category': 'security'},
    'n01d-ctf': {'icon': '🚩', 'name': 'CTF', 'desc': 'Capture the flag tools', 'category': 'security'},
    'n01d-osint': {'icon': '🔍', 'name': 'OSINT', 'desc': 'Reconnaissance & intel', 'category': 'security'},
    'n01d-stealth': {'icon': '👻', 'name': 'Stealth', 'desc': 'Network anonymization', 'category': 'security'},
    'n01d-mobile': {'icon': '📱', 'name': 'Mobile', 'desc': 'NullKia mobile security', 'category': 'security'},
    'n01d-automotive': {'icon': '🚗', 'name': 'Automotive', 'desc': 'BlackFlag ECU testing', 'category': 'security'},
    'n01d-forge': {'icon': '🔥', 'name': 'Forge', 'desc': 'Secure image burning', 'category': 'tools'},
    'n01d-machine': {'icon': '🖥️', 'name': 'Machine', 'desc': 'VM management', 'category': 'tools'},
    'n01d-dev': {'icon': '💻', 'name': 'Dev', 'desc': 'Development environment', 'category': 'dev'},
    'n01d-julia': {'icon': '📊', 'name': 'Julia', 'desc': 'Data science', 'category': 'dev'},
    'n01d-proxy': {'icon': '🌐', 'name': 'Proxy', 'desc': 'Traffic interception', 'category': 'network'},
    'n01d-vpn': {'icon': '🔒', 'name': 'VPN', 'desc': 'VPN gateway', 'category': 'network'},
}

def get_container_status(name):
    """Get status of a container"""
    try:
        container = client.containers.get(name)
        return {
            'status': container.status,
            'running': container.status == 'running',
            'id': container.short_id,
            'image': container.image.tags[0] if container.image.tags else 'unknown'
        }
    except docker.errors.NotFound:
        return {'status': 'not created', 'running': False, 'id': None, 'image': None}
    except Exception as e:
        return {'status': 'error', 'running': False, 'id': None, 'error': str(e)}

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/containers')
def list_containers():
    """List all n01d containers with their status"""
    result = []
    for name, meta in CONTAINERS.items():
        status = get_container_status(name)
        result.append({
            'name': name,
            'short_name': name.replace('n01d-', ''),
            **meta,
            **status
        })
    return jsonify(result)

@app.route('/api/container/<name>/start', methods=['POST'])
def start_container(name):
    """Start a container"""
    if name not in CONTAINERS:
        return jsonify({'error': 'Unknown container'}), 404
    try:
        container = client.containers.get(name)
        container.start()
        return jsonify({'success': True, 'status': 'running'})
    except docker.errors.NotFound:
        return jsonify({'error': 'Container not built. Run: docker compose build'}), 404
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/container/<name>/stop', methods=['POST'])
def stop_container(name):
    """Stop a container"""
    if name not in CONTAINERS:
        return jsonify({'error': 'Unknown container'}), 404
    try:
        container = client.containers.get(name)
        container.stop()
        return jsonify({'success': True, 'status': 'stopped'})
    except docker.errors.NotFound:
        return jsonify({'error': 'Container not found'}), 404
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/container/<name>/restart', methods=['POST'])
def restart_container(name):
    """Restart a container"""
    if name not in CONTAINERS:
        return jsonify({'error': 'Unknown container'}), 404
    try:
        container = client.containers.get(name)
        container.restart()
        return jsonify({'success': True, 'status': 'running'})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/container/<name>/logs')
def get_logs(name):
    """Get container logs"""
    if name not in CONTAINERS:
        return jsonify({'error': 'Unknown container'}), 404
    try:
        container = client.containers.get(name)
        logs = container.logs(tail=100).decode('utf-8', errors='replace')
        return jsonify({'logs': logs})
    except docker.errors.NotFound:
        return jsonify({'logs': 'Container not found'})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/container/<name>/exec', methods=['POST'])
def exec_command(name):
    """Execute command in container"""
    if name not in CONTAINERS:
        return jsonify({'error': 'Unknown container'}), 404
    
    cmd = request.json.get('command', 'echo "No command"')
    try:
        container = client.containers.get(name)
        result = container.exec_run(cmd)
        return jsonify({
            'exit_code': result.exit_code,
            'output': result.output.decode('utf-8', errors='replace')
        })
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/stats')
def get_stats():
    """Get system stats"""
    running = sum(1 for name in CONTAINERS if get_container_status(name)['running'])
    return jsonify({
        'total': len(CONTAINERS),
        'running': running,
        'stopped': len(CONTAINERS) - running
    })

@app.route('/api/all/start', methods=['POST'])
def start_all():
    """Start all containers"""
    results = {}
    for name in CONTAINERS:
        try:
            container = client.containers.get(name)
            container.start()
            results[name] = 'started'
        except:
            results[name] = 'failed'
    return jsonify(results)

@app.route('/api/all/stop', methods=['POST'])
def stop_all():
    """Stop all containers"""
    results = {}
    for name in CONTAINERS:
        try:
            container = client.containers.get(name)
            container.stop()
            results[name] = 'stopped'
        except:
            results[name] = 'failed'
    return jsonify(results)

if __name__ == '__main__':
    socketio.run(app, host='0.0.0.0', port=8888, debug=True)
