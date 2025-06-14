// 9K_AXON: Bodycam Script
// Refactored NUI script

document.addEventListener('DOMContentLoaded', function() {
    // Get DOM elements
    const timestampElement = document.getElementById('timestamp');
    const deviceInfoElement = document.getElementById('device-info');
    const bodycamContainer = document.getElementById('bodycam-container');
    const logo = document.getElementById('logo');
    const infoContainer = document.querySelector('.info-container');
    
    // Default UI config
    let uiConfig = {
        Scale: 1.2,
        Position: { x: 0, y: 0 },
        Logo: { 
            Enabled: true, 
            Scale: 1.2,
            Position: { x: -10, y: 5 }
        },
        TextSpacing: 0.15,
        TextShadow: true,
        Background: { Enabled: false, Opacity: 0 }
    };
    
    // Debug mode flag
    let debugMode = false;
    
    // Debug function
    function debugLog(...args) {
        if (debugMode) {
            console.log('[9K_AXON:UI]', ...args);
        }
    }
    
    // Apply logo position and text alignment
    function adjustLogoAndTextLayout(config) {
        const logo = document.getElementById('logo');
        const infoContainer = document.querySelector('.info-container');
        const timestampElement = document.getElementById('timestamp');
        const deviceInfoElement = document.getElementById('device-info');
        
        // Get logo position from config or use defaults
        const logoX = config && config.Logo && config.Logo.Position ? config.Logo.Position.x : -20;
        const logoY = config && config.Logo && config.Logo.Position ? config.Logo.Position.y : 0;
        
        // Get logo scale from config or use default
        const logoScale = config && config.Logo && config.Logo.Scale ? config.Logo.Scale : 1.2;
        
        // Apply logo transform with position and scale
        logo.style.transform = `scale(${logoScale}) translate(${logoX}px, ${logoY}px)`;
        
            // Get text spacing from config or use default
    const textSpacing = config && config.TextSpacing !== undefined ? config.TextSpacing : 0.08;
    
    // Apply text spacing
    timestampElement.style.marginBottom = `${textSpacing}em`;
        
        // Ensure device info has same width as timestamp
        const timestampWidth = timestampElement.offsetWidth;
        deviceInfoElement.style.width = timestampWidth + 'px';
        
        // Ensure device info has same left padding/margin as timestamp
        const timestampStyle = window.getComputedStyle(timestampElement);
        const timestampLeft = timestampStyle.getPropertyValue('padding-left') || '0px';
        deviceInfoElement.style.paddingLeft = timestampLeft;
        
            // Force identical styles for text alignment
    deviceInfoElement.style.textAlign = 'left';
    deviceInfoElement.style.letterSpacing = '0.2em';
        
        // Log alignment info if in debug mode
        if (debugMode) {
            debugLog('Timestamp width:', timestampWidth);
            debugLog('Text alignment applied');
        }
    }
    
    // Apply UI config
    function applyUIConfig(config) {
        if (!config) return;
        
        // Store config
        uiConfig = config;
        
        // Apply scale
        if (config.Scale) {
            bodycamContainer.style.transform = `scale(${config.Scale})`;
        }
        
        // Apply position
        if (config.Position) {
            // Adjust top position
            if (config.Position.y !== undefined) {
                bodycamContainer.style.top = `${20 + config.Position.y}px`;
            }
            
            // Adjust right position
            if (config.Position.x !== undefined) {
                bodycamContainer.style.right = `${20 - config.Position.x}px`;
            }
        }
        
        // Apply logo settings
        if (config.Logo) {
            // Show/hide logo
            logo.style.display = config.Logo.Enabled ? 'flex' : 'none';
        }
        
        // Apply font weight and shadow
        // Apply extreme heavy font weight for maximum boldness
        timestampElement.style.fontWeight = '900';
        deviceInfoElement.style.fontWeight = '900';
        
        // Apply subtle text shadow for better visibility
        const shadowStyle = '0 0 3px rgba(0, 0, 0, 0.5)';
        timestampElement.style.textShadow = shadowStyle;
        deviceInfoElement.style.textShadow = shadowStyle;
        
        // Apply background settings
        if (config.Background) {
            if (config.Background.Enabled) {
                const opacity = config.Background.Opacity !== undefined ? 
                                config.Background.Opacity : 0.5;
                infoContainer.style.backgroundColor = `rgba(0, 0, 0, ${opacity})`;
                logo.style.backgroundColor = `rgba(0, 0, 0, ${opacity})`;
            } else {
                infoContainer.style.backgroundColor = 'transparent';
                logo.style.backgroundColor = 'transparent';
            }
        }
        
        // Ensure text alignment and logo position
        setTimeout(() => adjustLogoAndTextLayout(config), 50);
        
        debugLog('Applied UI config:', config);
    }
    
    // Listen for messages from the client
    window.addEventListener('message', function(event) {
        const data = event.data;

        // Enable debug mode if specified in config
        if (data.debug !== undefined) {
            debugMode = data.debug;
        }
        
        // Handle different message types
        switch (data.type) {
            case 'showBodycam':
                debugLog('Showing bodycam with ID:', data.deviceId);
            bodycamContainer.classList.add('visible');
            deviceInfoElement.textContent = data.deviceId;
                
                // Apply UI config if provided
                if (data.uiConfig) {
                    applyUIConfig(data.uiConfig);
                }
                
                // Apply logo and text layout adjustments
                setTimeout(() => adjustLogoAndTextLayout(data.uiConfig), 100);
                break;
                
            case 'hideBodycam':
                debugLog('Hiding bodycam');
            bodycamContainer.classList.remove('visible');
                break;
                
            case 'updateTime':
                debugLog('Updating time:', data);
                
                // Format date and time components with padding
            const year = data.year;
            const month = String(data.month).padStart(2, '0');
            const day = String(data.day).padStart(2, '0');
            const hour = String(data.hour).padStart(2, '0');
            const minute = String(data.minute).padStart(2, '0');
            const second = String(data.second).padStart(2, '0');
                const offset = data.offset || '-0800';

                // Update timestamp display
            const formattedTime = `${year}-${month}-${day} ${hour}:${minute}:${second} ${offset}`;
            timestampElement.textContent = formattedTime;
                
                // Re-apply text alignment
                setTimeout(() => adjustLogoAndTextLayout(uiConfig), 50);
                break;
                
            case 'playSound':
            const soundFile = data.sound;
            const volume = data.volume !== undefined ? data.volume : 0.5;
            
                debugLog('Playing sound:', soundFile, 'at volume:', volume);
                
                // Create and play audio element
            const audio = new Audio(soundFile); 
            audio.volume = volume;
            
            audio.play().catch(e => {
                    console.error(`[9K_AXON:UI] Error playing sound ${soundFile}:`, e);
                });
                break;
                
            case 'updateConfig':
                debugLog('Updating UI config:', data.config);
                applyUIConfig(data.config);
                break;
        }
    });
    
    // Initial alignment (for development/testing)
    if (typeof GetParentResourceName === 'undefined') {
        setTimeout(() => adjustLogoAndTextLayout(uiConfig), 500);
    }
});

// 格式化数字为两位数 (不再需要，由Lua的String.format处理)
/*
function formatNumber(num) {
    return num < 10 ? '0' + num : num;
}
*/

// 更新设备信息 (函数不再需要，因为直接在事件监听器中设置)
/*
function updateDeviceInfo() {
    document.getElementById('device-info').textContent = `AXON BODY 4 ${deviceId}`;
}
*/

// 更新日期和时间 (函数不再需要，因为直接在事件监听器中设置)
/*
function updateDateTime(data) {
    const year = data.year;
    const month = formatNumber(data.month);
    const day = formatNumber(data.day);
    const hour = formatNumber(data.hour);
    const minute = formatNumber(data.minute);
    const second = formatNumber(data.second);
    
    // 仅更新时间戳
    // 注意：这里的 -0800 是旧代码残留，实际显示的是 Lua 发送的 offset
    document.getElementById('timestamp').textContent = `${year}-${month}-${day} ${hour}:${minute}:${second} -0800`; 
    
    // // 确保设备ID显示正确 (不再需要)
    // updateDeviceInfo();
}
*/

// Helper function to pad numbers (no longer needed, using String.padStart)
/*
function pad(number) {
    return (number < 10 ? '0' : '') + number;
}
*/

// --- Mock Data for Testing --- (移除)
/*
function sendMockData() {
    const mockEvent = {
        data: {
            type: 'showBodycam',
            deviceId: 'AXON BODY 4 X12345678'
        }
    };
    window.dispatchEvent(new MessageEvent('message', mockEvent));

    setInterval(() => {
        const now = new Date();
        const mockTimeEvent = {
            data: {
                type: 'updateTime',
                year: now.getFullYear(),
                month: now.getMonth() + 1,
                day: now.getDate(),
                hour: now.getHours(),
                minute: now.getMinutes(),
                second: now.getSeconds(),
                offset: '-0800'
            }
        };
        window.dispatchEvent(new MessageEvent('message', mockTimeEvent));
    }, 1000);
}

// 如果不在 FiveM 环境中，模拟数据 (移除)
if (typeof GetParentResourceName === 'undefined') {
    sendMockData();
}
*/ 