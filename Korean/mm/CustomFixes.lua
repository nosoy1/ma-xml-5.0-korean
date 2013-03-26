function applyCustomFixes(apkName, apk)
	if apkName == "MiuiCompass.apk" then
		showFixMessage(apkName)
		targetFile = FileUtil(apk:GetSubFilePath("/res/layout/main.xml"))
		
		if targetFile and targetFile.Success then
			targetFile.Data = string.gsub(targetFile.Data, "@miui:layout/android_transient_notification", "@android:layout/transient_notification")
			targetFile:Save()
		end
		
	elseif apkName == "Email.apk" then
		showFixMessage(apkName)
		targetFile = FileUtil(apk:GetSubFilePath("/res/values/ids.xml"))
		
		if targetFile and targetFile.Success then
			targetFile.Data = string.gsub(targetFile.Data, '<item type="id" name="main_content"">false</item>', '')
			targetFile:Save()
		end
		
		targetFile = FileUtil(apk:GetSubFilePath("/res/values/public.xml"))
		
		if targetFile and targetFile.Success then
			targetFile.Data = string.gsub(targetFile.Data, '<public type="id" name="main_content"" id=".+" />', '')
			targetFile:Save()
		end
		
		targetFile = FileUtil(apk:GetSubFilePath("/res/values-sw600dp/styles.xml"))
		
		if targetFile and targetFile.Success then
			targetFile.Data = string.gsub(targetFile.Data, '@id/main_content"', '@id/main_content')
			targetFile:Save()
		end
		
		targetFile = FileUtil(apk:GetSubFilePath("/res/values-sw800dp-port/styles.xml"))
		
		if targetFile and targetFile.Success then
			targetFile.Data = string.gsub(targetFile.Data, '@id/main_content"', '@id/main_content')
			targetFile:Save()
		end
		
		targetFile = FileUtil(apk:GetSubFilePath("/res/values-sw720dp-port/styles.xml"))
		
		if targetFile and targetFile.Success then
			targetFile.Data = string.gsub(targetFile.Data, '@id/main_content"', '@id/main_content')
			targetFile:Save()
		end
	
	elseif apkName == "framework-miui-res.apk" then
		showFixMessage(apkName)
		
		id = 5
		
		result = APKTool.InstallFramework("/system/framework/" .. apkName)

		for w in string.gmatch(result, "\\apktool\\framework\\(%d)%-MM%.apk", 1) do
			id = tonumber(w)-1
		end
		
		text = ""
		
		for i = 1, id, 1 do
			text = text .. string.format("  - %d\n", i)
		end
		
		targetFile = FileUtil(apk:GetSubFilePath("/apktool.yml"))
		
		if targetFile and targetFile.Success then
			targetFile.Data = string.gsub(targetFile.Data, '  %- 1', text)
			targetFile:Save()
		end
		
	elseif apkName == "LegacyCamera.apk" then
		showFixMessage(apkName)
		
		targetFile = FileUtil(apk:GetSubFilePath("/res/values/arrays.xml"))
		
		if targetFile and targetFile.Success then
			targetFile.Data = string.gsub(targetFile.Data, '<array name="pref_video_quality_entries">(.-)</array>', '<string-array name="pref_video_quality_entries">%1</string-array>')
			targetFile.Data = string.gsub(targetFile.Data, '<array name="pref_video_quality_entryvalues">(.-)</array>', '<string-array name="pref_video_quality_entryvalues">%1</string-array>')
			targetFile:Save()
		end
	end
	
end