Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2BC7081A
	for <fstests@vger.kernel.org>; Fri, 14 Mar 2025 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967063; cv=none; b=QYX4dZPR8kDsZenHNuatmTpH1BaIW/rUjMtjSbTkf4atAJ5Tv/184AK5SWRmOXsKDc8G2oSGmpkOQJGHIWoiuJFZw0dhvEU0GbaLXEpHpDEfohGTrIU7SMC/K6QfWaGDbxY0GwXsso2/MgWcsHVbqUfxxd/ksJZaaJphe09EGvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967063; c=relaxed/simple;
	bh=bR9ZCrLljkOblOutLe8qHJMvJznQPBKxsceiE3etzCI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=h7EPkBjULbnPVGtyd8QH3IVZGEHp5wy23c+BtxQDDE1hP6XQ16QmRSTMSCvgezLmdK+F66jrWvcYbT+c7GUm3R3oXDwZfb3L1ZN5yeThRWV4GhFBZ+CgR5wfTZBpnpqHwXZN4Y3EpuIiLK2jRP6D28ccjhc3lkx3KBTZFtmaD+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cl3Hb7Ph; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cl3Hb7Ph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741967060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9yndP2A+lp7EaXKjVHj9H6ChpLqudODcu7iYqC/wZLM=;
	b=Cl3Hb7Ph3d+7N39od77jT5VUdX4HVBIP1blIWmUTc5fX9HFkAUtBNV8NW5tc81izE3w0lV
	5F01eHCwGSmWb3GWrQ56eQnydiKdE7i8PodovQTUBS3RUrdd82HFpX43W7OhISqFz1TWAk
	NkMLKanY7PNtB0J/GIoEzU+Fr1H2f+U=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-PUAKUkF3PdOJl415KxD7Pw-1; Fri, 14 Mar 2025 11:44:18 -0400
X-MC-Unique: PUAKUkF3PdOJl415KxD7Pw-1
X-Mimecast-MFC-AGG-ID: PUAKUkF3PdOJl415KxD7Pw_1741967058
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d4423d0c49so21005535ab.0
        for <fstests@vger.kernel.org>; Fri, 14 Mar 2025 08:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741967058; x=1742571858;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9yndP2A+lp7EaXKjVHj9H6ChpLqudODcu7iYqC/wZLM=;
        b=VsJtbRY6XkCkuBWp4o9kjYe1UO5zGiJ0gnJQpzJF/ACLMNuJsAdRT7hgOBYesJlLqG
         OG+X/DlBID4M/sRpTLbMMblvIEGMt/iyZWte+1jl4b8XoeqmXFsbj9wP2a5IFx+smj2F
         DhkGdabiklJfUFbMCYD0E/z1POAACvlAAi1ArLEQhbxxBWVDQOZfWMHt7g/IpBN+DNgB
         IPxIG0xTw/1yZCb8fir0EguQ3EtWQN9kf7maR+/HEG5yfxU1LCrAqM+5QTee/uDYrp+8
         vSm20KJJXRXLEKqqrOKaOCYfG6n0oxOIlmyZrgrKT/nwgZUQMA/PG5JKICWDhmIpaDb1
         Pnow==
X-Gm-Message-State: AOJu0YzaRRxAakONooATG+V3tzGfKOGrqMoJ6mgmGzdS/AnQFfQYxNFs
	At/wLoaWEyE1YXLVCz7ZUO6uTdzz3mUJTTDnGHCHV0/oK8nEYF/8pN8HPZeBVAWL7k2+mMLjFKD
	J95DebY9d4qsjJ5MCbOa6/PmSGmbOlw2AAy/fPwFHKMgixhYUH7VnSFM3t2hfd+Z2kdwJe1oZ7z
	FkZl0LW8pFh4N3yUBFJM74cVF4yFGcl2sApNR18gr3
X-Gm-Gg: ASbGnctgJ3u98OMPd/vzuIcmEYvj+MpF6Ig8via5kAYfGRTeec4BpxqHroH4NYhtTyp
	rX0t/L2OL5zX7a021L7XPDY7fVuGm5pscYQmlnrjAKWPs7eUGWMAnwcCIOjkea9Kem5w4lDIkFe
	vd/4nN3FuwAKDDedR+uQRTZQ5RQIR6OxRl+H1OLIuIf08gt9VlW/B0evRGcRw9eSPahmp1xfeQK
	b93gZUnJSBec3ceDOs4yV6w7WYQKuKrNjHg04/8GoJbKDDjLXNizH2nSRzJnBXZF4lCgPKl6fpz
	kO2OICgGM36HT/9qMRn172I=
X-Received: by 2002:a92:c262:0:b0:3cf:f844:68eb with SMTP id e9e14a558f8ab-3d4839f4312mr26932295ab.4.1741967057955;
        Fri, 14 Mar 2025 08:44:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvZAWaBLi5tT9CumU69YuYJnnNZFtRYzmAad4le8t65dq30dN0trrsE1jz1i0OCjZOwWgw/g==
X-Received: by 2002:a92:c262:0:b0:3cf:f844:68eb with SMTP id e9e14a558f8ab-3d4839f4312mr26932125ab.4.1741967057561;
        Fri, 14 Mar 2025 08:44:17 -0700 (PDT)
Received: from [10.0.0.176] ([65.128.97.82])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f263719436sm916133173.33.2025.03.14.08.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 08:44:17 -0700 (PDT)
Message-ID: <5637d8c8-d92e-43b0-95b6-a8decc5e2025@redhat.com>
Date: Fri, 14 Mar 2025 10:44:16 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH V2] fstests: test for CONFIG_QFMT_V2 in _require_quota
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

When CONFIG_QUOTA is enabled but CONFIG_QFMT_V2 is disabled in the
kernel config, many quota tests on ext4 will fail in odd ways,
when in fact they should be _notrun. Add a CONFIG_QFMT_V2 test to
_require_quota() to catch this for filesystems that require it.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---

V2: add _require_quota to ext4/055, because it adds the -O quota
feature at mkfs time, and mount fails without CONFIG_QFMT_V2.
Jan, I took the liberty of leaving your RVB: despite that minor change,
please let me know if you object. Thanks!

diff --git a/common/quota b/common/quota
index e306e2e3..a51386b1 100644
--- a/common/quota
+++ b/common/quota
@@ -16,6 +16,7 @@ _require_quota()
 	if [ ! -d /proc/sys/fs/quota ]; then
 	    _notrun "Installed kernel does not support quotas"
 	fi
+	_require_kernel_config CONFIG_QFMT_V2
 	;;
     gfs2|ocfs2|bcachefs)
 	;;
diff --git a/tests/ext4/053 b/tests/ext4/053
index 5922ed57..77b3ac81 100755
--- a/tests/ext4/053
+++ b/tests/ext4/053
@@ -45,7 +45,6 @@ _require_loop
 _require_command "$TUNE2FS_PROG" tune2fs
 MKE2FS_PROG=$(type -P mke2fs)
 _require_command "$MKE2FS_PROG" mke2fs
-_require_kernel_config CONFIG_QFMT_V2
 
 LOG=""
 print_log() {
diff --git a/tests/ext4/055 b/tests/ext4/055
index 3117bf15..711d18c2 100755
--- a/tests/ext4/055
+++ b/tests/ext4/055
@@ -14,6 +14,7 @@
 # The test is based on a testcase from Zhang Yi <yi.zhang@huawei.com>.
 #
 . ./common/preamble
+. ./common/quota
 _begin_fstest auto quota
 
 _exclude_fs ext2
@@ -23,6 +24,7 @@ _require_scratch_nocheck
 _require_user fsgqa
 _require_user fsgqa2
 _require_command "$DEBUGFS_PROG" debugfs
+_require_quota
 
 echo "Silence is golden"
 

