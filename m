Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA212D023
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629357; cv=none; b=Y5mlTYIpYnkrLDyS1PgrcDtCihEFrxvWpofx4lamlV8J3bc55CJxbxIgBEjfyKwtH/EedWakpSp5lapIOtCRaswYAeps+ecZ0FxD9XptcVRKbMVTIuQ/TIdl0BViZpm8VCo5a/znMm4LTKCaEduATU9b/swDXOeXDx6XJHOPBr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629357; c=relaxed/simple;
	bh=AyqGlYXjcEvTYFCkoAO+0oCampNroVjZ+OMftPf2CYY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=B79LO4dUmSR0+co2QydI4eN/Z35ZE9G6fvMcaCK2czAHZJS0amM0v8Pv9ntjwlSLPnxFGodSkewiTemJQeKBEIvb6LblmUqzgIgNiTS/tJk24PFzv6C84eQa0TDXVW2MUju6C5L2rEdu2daCJe1PDzah4Nl4ohH/GMdmY3HD5NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QAhwT9Th; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAhwT9Th"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741629355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5NmBOKL3X99OQVkyx+4bXwP1qHiJjG4uD3oX98G9U5A=;
	b=QAhwT9ThJzag0vu/znXNLLCG36HfBbQOuo/EKUo0zjmDK7XmW3rlB2JOH6Jl/D3hztgZmi
	yov0a2bTuYsHedqcnWISHIgw1OV0jWgCETJqIhwr0dRGtCq+uGsoui2UBzwI45Dh90D7EH
	SdiRPymr4RLetzGVruVe8GxSM1SWG3A=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-UqyUEau0Of-6zOs0Y7bOPg-1; Mon, 10 Mar 2025 13:55:53 -0400
X-MC-Unique: UqyUEau0Of-6zOs0Y7bOPg-1
X-Mimecast-MFC-AGG-ID: UqyUEau0Of-6zOs0Y7bOPg_1741629353
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d453d367a0so44624505ab.3
        for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 10:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741629353; x=1742234153;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5NmBOKL3X99OQVkyx+4bXwP1qHiJjG4uD3oX98G9U5A=;
        b=QZey4rS25BHUnJR+5tbFhcvjWUQNglxFddHEQaXrQ/HCbodd/QTd+ybSM5OBz2p+pH
         MebCuUKNoR8iX6bXqui09bHmkZZDpFWv03N7Qn7PK1CVRqhmUdELnww6KDKJKW3s8c67
         HGf95FtC84UTBWTOnhOrAvZj4366iYfhnIvmiQKmMFmeYq94mxnnswdKpoltS4AftFZ1
         Sn7g+ZmU8Xuf8I7wIUTNedDHDXn3w/ndG0PGUrxs6vjiosRI4u0vPpOywum+T2uUvFWJ
         GZ+3+jHq+l96sGP/OSSkUDNP4TCBdh8qjczkUgYEAoAp/hokYspn7aULtXbweYJ1mcU4
         Yg9Q==
X-Gm-Message-State: AOJu0YxhOOhawxxDE6d1MVWuxkzAv2+aZNUWy4gFTG+UQonVTCtE6LPo
	fcT70iXd0yOU7hBmuN1GnPlHxHlOKhtmWHi/5JscPmW981j7zYqvnPUtlPpbEsygDr6iSHhsUsf
	gvS5rQOytFGLI4PAQxzgf/ACuAr0DVvHYvnWs5lq/9R4aueYcyijN4CF5NEx2cL2utY5HaylWLZ
	y4uRpzpEQkvef6MhxWnsoSlYytBUfaZsQy7bb/hAeZ
X-Gm-Gg: ASbGnctYW1MqTYjXkM5GfL6flnieAtUoeb/dbsaZndpwvySuYhJSWNe1xdRZQv9na5e
	Nma1qW1bqAMYNtd1zYYDAC7Bg9vavFuIL8xaYtuH3T5+bo2sP0AjMJ0kYFb2rxbFU8s6YGgeOcV
	961rgYeWlB0JdoOsX3i+IH1AY4c/K0XcSOQiQ+kxFzfGQ+6cfIn5BAwl3TBSRItUjMbAmXjKoLq
	yap+AS6di8cemjQZpsF7Rs7AkpG+D+god4X8VKOak5Gb2HS67EGAYldtAhDiIP5pJFoBt3n2bPq
	kCNk4qJuohQwdG5B8YddQDw=
X-Received: by 2002:a05:6e02:1c2b:b0:3d3:d00c:3602 with SMTP id e9e14a558f8ab-3d46890f7c1mr6675095ab.10.1741629352829;
        Mon, 10 Mar 2025 10:55:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWaBeIiY7Z0eNwcYVXg/Yjl0WOE9IlOWZ22sCOEl+cIiyD4lK026vmyZUNSBKWlKolYSRpmA==
X-Received: by 2002:a05:6e02:1c2b:b0:3d3:d00c:3602 with SMTP id e9e14a558f8ab-3d46890f7c1mr6674865ab.10.1741629352493;
        Mon, 10 Mar 2025 10:55:52 -0700 (PDT)
Received: from [10.0.0.176] ([65.128.97.82])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209df4bb5sm2409776173.21.2025.03.10.10.55.51
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 10:55:52 -0700 (PDT)
Message-ID: <52747027-2915-4c92-a6e9-b0dce1cbe198@redhat.com>
Date: Mon, 10 Mar 2025 12:55:51 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] common/rc: use getent when available
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Zorro noticed that on systems using nss-altfiles, some tests failed when
trying to parse /etc/passwd directly. The "getent" command does the
right thing in this case, so let's use it as long as it's available.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/common/rc b/common/rc
index 6592c835..50312331 100644
--- a/common/rc
+++ b/common/rc
@@ -2621,7 +2621,11 @@ _yp_active()
 _cat_passwd()
 {
 	[ $(_yp_active) -eq 0 ] && ypcat passwd
-	cat /etc/passwd
+	if type getent &>/dev/null; then
+		getent passwd
+	else
+		cat /etc/passwd
+	fi
 }
 
 # cat the group file
@@ -2629,7 +2633,11 @@ _cat_passwd()
 _cat_group()
 {
 	[ $(_yp_active) -eq 0 ] && ypcat group
-	cat /etc/group
+	if type getent &>/dev/null; then
+		getent group
+	else
+		cat /etc/group
+	fi
 }
 
 # check if a user exists in the system

