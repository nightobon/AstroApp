package com.example.backend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.example.backend.service.DeviceScanService;
import com.example.backend.service.UrlScanService;
import com.example.backend.model.ScanResult;

import java.util.HashMap;
import java.util.Map;

@RestController
public class ScanController {

    @Autowired
    private DeviceScanService deviceScanService;

    @Autowired
    private UrlScanService urlScanService;

    @GetMapping("/")
    public Map<String, String> home() {
        Map<String, String> response = new HashMap<>();
        response.put("message", "Welcome to the Cyber Security App API");
        return response;
    }

    @GetMapping("/api/smart-scan")
    public ScanResult smartScan(@RequestParam String scanType) {
        return deviceScanService.scanDevice(scanType);
    }

    @PostMapping("/api/url-scan")
    public ScanResult urlScan(@RequestBody Map<String, String> request) {
        String url = request.get("url");
        return urlScanService.scanUrl(url);
    }
}
