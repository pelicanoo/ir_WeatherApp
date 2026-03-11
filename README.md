![preview](img/img.png)

# Forked from https://github.com/Rovlgut/ir_WeatherApp. Thanks to Rovlgut for the original work.

This is a very basic implementation over Rovlgut's original work, with little changes to fit my personal preferences. 
I haven't updated this implementation to the latest version of Rovlgut's original work, so it may be missing some of the latest features.
This is intended for personal use, but feel free to use it as a base for your own implementation. 
I will not be maintaining this fork, so if you want to use it, you should probably fork it yourself and maintain it.

# Description

Weather App for Kapps. Based on [iRacing Browser Apps ](https://ir-apps.kutu.ru/).

Shows track wetness, precipitation, humidity, track state, track temp and air temp.

The track wetness text blinks red when track wetness is going up, and blinks green when track wetness is going down.

![wetness](img/wetness.gif)

# Install

## 1. Download the latest .zip source code from the [releases page](https://github.com/pelicanoo/ir_WeatherApp/releases).

## 2. Create the Custom Apps folder

Create a folder where your iRacing custom apps will live. I'm creating mine inside the iRacing folder in Documents but you can create it anywhere you want.

    %USERPROFILE%\Documents\iRacing\CustomApps

------------------------------------------------------------------------

## 3. Copy the WeatherApp files

Copy the entire `WeatherApp` folder into your CustomApps folder.

Final structure should look like:

    %USERPROFILE%\Documents\iRacing\CustomApps\WeatherApp

Inside the `WeatherApp` folder you should see:

    libs/
    css/
    fonts/
    app.coffee
    index.html

------------------------------------------------------------------------

## 4. Add the folder to Kapps

1.  **Start Kapps as Administrator**
    -   Right-click **Kapps**
    -   Click **Run as administrator**
2.  In **Kapps**:
    -   Go to **App tab → Settings**
    -   Click **Add App Folder**
    -   Select your CustomApps folder

------------------------------------------------------------------------

## 5. Add the overlay in Kapps Racing Overlay

1.  Open **Racing Overlay**
2.  Scroll to the bottom
3.  Click **Add Custom Overlay**

Configure it as follows:

**Name**

    WeatherApp (or any name)

**URL**

    http://127.0.0.1:8182/WeatherApp/

Tick the options you need.

------------------------------------------------------------------------

Original author: **Rovlgut**