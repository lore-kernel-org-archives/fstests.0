Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB98246768
	for <fstests@vger.kernel.org>; Mon, 20 Oct 2025 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968565; cv=none; b=R42wUwY2QESTBcuGtmMaHUaMQgWwpB+rAR4USVJMuQt2qlqdRoXJiP7Jqtcck9RM29gim2yUduLMotLutNr8Qrx/SM6wnvWIueWIZ/bTIbeW8Bi09D0+IV8AWuMaOiGbSel8vCc2l3I72qDh3YgjPJ8fin749F2OS6/Iq/V2Z1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968565; c=relaxed/simple;
	bh=yGp/NxJkcclLX/oxsMmnaFG7uXGzDm3sgbQh2bb8Y2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TW6F09TE/4RorJ3xKw9PUY04rbAm4M1TjKdYysGEGIGyso4qqSsA+qdxZwMuoSU2xaCwaW7rRXRVO6nRks7nWb0ASKSHmRU246CWaDGvqyoqheAcmoARTJPsQhTGZCKZPkHW4HFCj662cXQ1HNqmkDWNe+z2VogF51R35p97aNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7m4dqFP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7m4dqFP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760968563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joqZRkk4+TwVEW9KnzmZmcPW11H9Yujd1P1x2lAPzHE=;
	b=V7m4dqFP9472Aov1kttPDLHsgdAIndLioByOncfgUJu7GKvKgXYgScPrPI28Xfaqy52Ra0
	gjfLUsbVtx83+q553aiPkaeEttkyFIWtSbuQ4pwZebRzWqQIIJ35ePkV76I+KpryJH6LTD
	Zq4oxPcYyNx6sM3wpbrMLOJfhNdgM00=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-IlsVZsooM-COMoNvDoNjPQ-1; Mon, 20 Oct 2025 09:56:01 -0400
X-MC-Unique: IlsVZsooM-COMoNvDoNjPQ-1
X-Mimecast-MFC-AGG-ID: IlsVZsooM-COMoNvDoNjPQ_1760968561
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee130237e1so1827517f8f.0
        for <fstests@vger.kernel.org>; Mon, 20 Oct 2025 06:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968560; x=1761573360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joqZRkk4+TwVEW9KnzmZmcPW11H9Yujd1P1x2lAPzHE=;
        b=JBp1wiYWaNy30r2br9yD/UAaHePUwmUVJ9ucxRRS2rZJkNkhKeL9rQOrt1zfgSodP8
         ArVOumzStoSutCm6a8cfcnaic48FCOfj0q/Bmx+kyprdqrav9F11AUQt6g3IaXQbvhsX
         tfabZS88qVQVmETqCghZKu3yfNLmi5o4x8zQzS3lkOkuDj3OSUxkatxnW3AFpa5kTtBI
         zlyssG/1kqRu8veKu2+RX28sfggdkfIPbgFMElonByhySO6jesSYD3rOa9p5RQBWgXtz
         YvMAUYcmH+F7ePXno11yRu2MjTu+6Iw1POPwSB2p5J5canMNI7zy+CVSc+E7KJ5uf+YJ
         kHLw==
X-Forwarded-Encrypted: i=1; AJvYcCX0qjVnOBERQ5jlulctTU5MKYMBA2J8M8P+IT3H6FiXcp8kAMl3Nx9crcH7jms6lbS6DL8bCIG4@vger.kernel.org
X-Gm-Message-State: AOJu0YzIDTAHHfNIizHWADFf1wf3UiGY4lKnKi+qRlq8cBl9uF0+5bkp
	TblsyMWPCbdR5/jX9/GWSezaf0IwqJ5qn36RGU5lB/rpIQN59D+lqJ4mfl+3y3AjLlwOA+iLTci
	TdtR9oHa9N51ICwbxp6V7pl2bdkhjahTj5E3ofTXUe/qjKcD/PgCLyGX0wQ==
X-Gm-Gg: ASbGncsbD15OJgxCqPMMNmDblu9bIg2Z3JfTWCzfbgKP9NiiNb8DcqAGwOJ97JWuSjw
	GaiQsLuLTQfFBpwU5oUnN7qj9N9Qg36R1IdrcNBKtIZjygMrd8ecATi/cBWATW0McMo7yeemzA3
	eGCaJvH7BwMHgIYYlXA0BneZOixeexu8y5et9uN9+lGnQpzAaZ3H0wVzTiJOQXWIlPpLz8pMcPT
	hlf2nfbs/3RC/vbcOFfgG+XSyqqUHDbpi+8fd4KssW0tjsPnoIE4R66m/WxQJk793zhpmf4RHOl
	vBH01ov6MwcIC7Htxifir7PTlkskWunYhI+ct5+sUCe6GfPP3zwP7hDlSNjyTl8LYK4El8uot5U
	1TGnRdVjNs9mLdLIBNrhrmjb4+KV0CSEmag==
X-Received: by 2002:a05:6000:2889:b0:428:3e6b:8deb with SMTP id ffacd0b85a97d-4283e6b8e84mr5337669f8f.61.1760968559186;
        Mon, 20 Oct 2025 06:55:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERmRBSiPso4Fx/JyEpbSHJUDtjom7V3U8lKN/pPy8a4YxPD063xQIzuzCItfdNELs2meiroA==
X-Received: by 2002:a05:6000:2889:b0:428:3e6b:8deb with SMTP id ffacd0b85a97d-4283e6b8e84mr5337639f8f.61.1760968558643;
        Mon, 20 Oct 2025 06:55:58 -0700 (PDT)
Received: from thinky.redhat.com (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47152959b55sm151404645e9.6.2025.10.20.06.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 06:55:58 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: djwong@kernel.org,
	zlang@redhat.com,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH 1/3] common/filter: add missing file attribute
Date: Mon, 20 Oct 2025 15:55:28 +0200
Message-ID: <20251020135530.1391193-2-aalbersh@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251020135530.1391193-1-aalbersh@kernel.org>
References: <20251020135530.1391193-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add n (nosymlinks) char according to xfsprogs io/attr.c

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 common/filter | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/filter b/common/filter
index c3a751dd0c39..28048b4b601b 100644
--- a/common/filter
+++ b/common/filter
@@ -692,7 +692,7 @@ _filter_sysfs_error()
 _filter_file_attributes()
 {
 	if [[ $1 == ~* ]]; then
-		regex=$(echo "[aAcCdDeEfFijmNpPsrStTuxVX]" | tr -d "$1")
+		regex=$(echo "[aAcCdDeEfFijmnNpPrsStTuVxX]" | tr -d "$1")
 	else
 		regex="$1"
 	fi
-- 
2.50.1

