Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADA8202C34
	for <fstests@vger.kernel.org>; Fri, 14 Mar 2025 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963020; cv=none; b=LIad74MwUHfVpv3kgpUlCKj9Zenx8/fm9RgMeJynmcmLfa2rVV4+6focg7P32HnX+UG7REKgSLd0YqgbwtFIT1TxOgznfpfxc0TMcPL2ct0nggUi/QjIkhpZyqnOVRtXfwPEH4sEpdXyAlUrzevVqw0QrDtDCru1u+oFwXJTqXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963020; c=relaxed/simple;
	bh=IA2yzTb5y4p1IU9zttcKwpyBRcmzgroMBNoS6lg//tg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=SErdSY9RgawZ77H5g9Sjg2sBAYk96LGdBqjbdaTtdHS6KaesskN+irf1vi0lOCq7jOxr4nXnXDgl4m7V0Fp5mzrVKg/4vZuTPyAkC1OzsNzbB9tVjDsOcUjbfKALaMcPRDIO0nU42SbpdohQCDFSLtBhff+1K5N2fwaTujaEh2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EsKpwqVQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsKpwqVQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741963016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eyt0wyzS9v/6ZehUMNv0fObOSKpPXF2i2F+B0E1faVo=;
	b=EsKpwqVQppKXbMQpldib6VLhbNiMvFwwQrDSVLHVT8WG2/ZkQlLxxU/MD1uIREGKYvvJvZ
	Rw4jBY+tdssiRlMNKd3uMyvyEZHPblPThEAXCKXngplAIiQRB3flym21xBlu45ZNSxXsvm
	f0ru2nchKje8OdjJQn+kCm1loiL8Vyc=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-02mGfWa_Onek_alwxUay1w-1; Fri, 14 Mar 2025 10:36:55 -0400
X-MC-Unique: 02mGfWa_Onek_alwxUay1w-1
X-Mimecast-MFC-AGG-ID: 02mGfWa_Onek_alwxUay1w_1741963014
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce81a40f5cso43464045ab.1
        for <fstests@vger.kernel.org>; Fri, 14 Mar 2025 07:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741963014; x=1742567814;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eyt0wyzS9v/6ZehUMNv0fObOSKpPXF2i2F+B0E1faVo=;
        b=JNje5z+XJRCqBRwaJFAJDqL9GJ2UcuxnKP4zm1CUaPTtcHGKxwlM3nD2a+WX9kc6M2
         UkTWDMnyZa1nNnFmD723Hf//qCSl2YKT03rSWPLNXNfk9azxXCifFIL/y0/EfAJy95b/
         5/UABhKAxlgypEWHuPMs3suT2Hn97LdsRaquwsMPnsh7t/NgNEA15oD6ufVvIA9eVz2n
         q5KBQ1zH5UOdA5Pira3Ta3pkIIcyFktBDsw6luoCHPsnfM7tBK/CEGdy53soJoBifldw
         ixZvog3Zeui4iaaC8f1PB6/k/ZWTB8MSw39+XxTdh8pPWoXyOPf/SQKfflqiScCGtEmX
         li6A==
X-Gm-Message-State: AOJu0YyI8Zzlg3Ng2mVMbjd3MtPPcvKQJdZcaAP9GSfjF71bsHejuaT6
	RmU1o5R19yQH4RCuwh9QsjiwcF8EtD0zJJwkO9t44O3q/dP/H2sfGWNnDwxd9nWPBLNBwDb0zF+
	kDjAHMyiSTgQnpStFj0Wm64GybZV/dZ0L4j7AgW+qC8LLDNTKfyJEguu1XIIODTCLrtlDNZ3UzQ
	udme6BZvzSn1Hka7naFQzpGbmmXarACuGIek8caIDh
X-Gm-Gg: ASbGncvcrHwKIvH0m14xPabQdX7E24+22qtdOS5Z8/jiYPpVdWFdWMp21ctJe6gxYh5
	/BQdU3Q2O4wIOyROQHa+qX+SXXaG2zYRU7ynJ7Awsk13ObckBbuhZ1JhOOtNbGYBtIrfmYY0esB
	F4zw7Xu2boPzP/TC0RfkuHc+/L34jXDHpiH67mQ9WNa0mr/6s2Pabu5NXeh89gY8d4pxpcs/m5Q
	Eyge8AlJD5bW0O6/iK4jYaDCpDRJefo793Iiyn7Yy6ZDL/+YvMAMLmua+ZTkfP82S3+6V4gfE8k
	kxzfQP1FaeR2pR12HFlvqqg=
X-Received: by 2002:a05:6e02:3687:b0:3d4:35d3:87d3 with SMTP id e9e14a558f8ab-3d4839f6027mr28160555ab.4.1741963014392;
        Fri, 14 Mar 2025 07:36:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnP3cvCq1RGGjXzH2qTT9qCDOpzPHAeHieXDS/9U7SXCPgNQO5dmUFGMrw5lHhWceKVm06kA==
X-Received: by 2002:a05:6e02:3687:b0:3d4:35d3:87d3 with SMTP id e9e14a558f8ab-3d4839f6027mr28160255ab.4.1741963013959;
        Fri, 14 Mar 2025 07:36:53 -0700 (PDT)
Received: from [10.0.0.176] ([65.128.97.82])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f263727457sm871581173.68.2025.03.14.07.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 07:36:53 -0700 (PDT)
Message-ID: <aaf2e2de-b337-4d7f-81fe-1aa8ef6b6b21@redhat.com>
Date: Fri, 14 Mar 2025 09:36:53 -0500
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
Subject: [PATCH RFC] fstests: test for CONFIG_QFMT_V2 in _require_quota
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

When CONFIG_QUOTA is enabled but CONFIG_QFMT_V2 is disabled in the
kernel config, many quota tests on ext4 will fail in odd ways,
when in fact they should be _notrun. Add a CONFIG_QFMT_V2 test to
_require_quota() to catch this for filesystems that require it.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

Backstory:

I was handed a bunch of ext4 xfstests failures on a system which had
(accidentally?) been built with CONFIG_QUOTA enabled, but with
CONFIG_QFMT_V2 disabled. This led to lots of tests failing when in fact
they should have _notrun due to lack of sufficient quota support, and
the reason for the failure was not obvious.

I'm going to just admit that I get lost in the maze of
quota kernel configs, mount options, and on-disk features:
CONFIG_QFMT_V1, CONFIG_QFMT_V2, vfsold, vfsv1, vfsv2, usrjquota,
tune2fs -O quota, etc. I think that requiring CONFIG_QFMT_V2 might
be a little bit heavy-handed here, but perhaps in the name of simplicity
this change is reasonable, and I cc'd Jan in case he sees a better
or more fine-grained approach, or if there are certain quota tests
which should not require CONFIG_QFMT_V2, or if we should check for
CONFIG_QFMT_V1 as well...

(Even on my old RHEL7 hosts, CONFIG_QFMT_V1 is disabled, so I don't think
it's worth a separate check.)

There are a couple tests which oddly enough still succeed even with this
kernel feature off - generic/234 for example. It does quotacheck and
quotaon - the latter of which fails, but is ignored, then a bunch of
setquota calls which succeed. I'm not sure what to make of that, I guess
userspace can happily write to the quotafile without the kernel needing
to understand it, but the kernel cannot do the accounting ...

generic/280 is similar.

So this change would _notrun those tests even though they only exercise
setquota, and do not require kernel functionality. I'm not sure it's
worth carving out special cases for them, though.

Thanks for listening ;)

diff --git a/common/quota b/common/quota
index 3bf7d552..237fc115 100644
--- a/common/quota
+++ b/common/quota
@@ -5,7 +5,9 @@
 # Functions useful for quota tests
 
 # checks that the generic quota support in the kernel is enabled
-# and that we have valid quota user tools installed.
+# and that we have valid quota user tools installed, as well as
+# support for the modern on-disk quota format kernel config
+# for filesystems that require it.
 #
 _require_quota()
 {
@@ -16,6 +18,7 @@ _require_quota()
 	if [ ! -d /proc/sys/fs/quota ]; then
 	    _notrun "Installed kernel does not support quotas"
 	fi
+	_require_kernel_config CONFIG_QFMT_V2
 	;;
     gfs2|ocfs2|bcachefs)
 	;;
diff --git a/tests/ext4/053 b/tests/ext4/053
index 4f20d217..45747317 100755
--- a/tests/ext4/053
+++ b/tests/ext4/053
@@ -46,7 +46,6 @@ _require_loop
 _require_command "$TUNE2FS_PROG" tune2fs
 MKE2FS_PROG=$(type -P mke2fs)
 _require_command "$MKE2FS_PROG" mke2fs
-_require_kernel_config CONFIG_QFMT_V2
 
 LOG=""
 print_log() {

