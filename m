Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9205449620
	for <fstests@vger.kernel.org>; Thu, 18 Sep 2025 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758155597; cv=none; b=ovKq+wMKoXy6uOL3rQ8XoUtfpVYwV76MehqXabDQxpr+Kde2UoAvMaOpEd14lbqitC/L8PpMnZudfxZ9v0a9T0QsLNBUNwVLN61WCGAyVMKNygRW8Cm6A9JKmbDY9qgrb72cLWTe8JJSNuSMbM4K1BATSFnaRUqLsioOBJPaVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758155597; c=relaxed/simple;
	bh=S56k4VPaH+gYIeZLtS2pAw9+CBYHbkyGAJiAFP0N1nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeMl0e+8zsID+Z16joFQF2wzpsJ2v2LBFZzwLayVncIPzaiZ2pnTvWMzN3z1XC79Xr/U7Tej9VmaElidNwTxKZdWIbSCyn9/Q2yDMomjOkzd/C07GwlVQAZ90voCIZv6gB0xYNrAJeWBzmxoUmDpeJYtlR7UzeqQEspJ9KAjdLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ET0m3/pq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET0m3/pq"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77459bc5d18so347797b3a.2
        for <fstests@vger.kernel.org>; Wed, 17 Sep 2025 17:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758155594; x=1758760394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKAzJ4zzOm4qzuhrKmfm70Ds2VFgXDcQpUBdAlsdf1c=;
        b=ET0m3/pq5hwIgHFS8h53zw6cFQf91ry5C3lPId7n+BHeSSyWOWHYsaYHdySgkKuA69
         cTjsztQTYvsUPsyIrjKUiTM0ugB+f9B5wJCF9FDe91qqrT8cffIUm8j9KYpqv1bSB1Nc
         suWWoH/5YJglRYlh/ft4nte7gsj7ubfZjGm5N1cY3OdXHh3DL+KluFVIi6DMwGic7cJk
         64ed0DeVr7UUGjVrJkBWu3PDYC5oDNT0eY8eiAY075E2IuW3UCJI9rxUnAVT/pnYAtGf
         N9ZHWUpIspKa846lnTzVdtDHS2TT1IpsNo1LnKIomZHCzrTLQvF52g/vgrZjxTzG/NAG
         O7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758155594; x=1758760394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKAzJ4zzOm4qzuhrKmfm70Ds2VFgXDcQpUBdAlsdf1c=;
        b=RIo1ARn6vtt/BospmZxxYjCKQkj9P7ofcBTDJ3IWcEPNij9HGWGJlDhOTRdusuD9aG
         R1B34DUSY6Sy/Ql7ScG2U6EGd8W8++6mreu7wZOiwGTpqRfj9FiVAQg4RNjZfeif/o0P
         lof7VceLUfcTg9GEbr9HbfoPnMO183jceRzuR07UIPkRtA850h7wYpofM8rFekTHYgwx
         9pQGzUtp2e2pKju1jJ7vHXvYyg04RI9hk/tJ/TeIKA5T86I592UQpgNnPWRqbVPsCtef
         mK6eitdXXnspjQun3BYzgAepIbF8yqH5DQUNWme9Q4YvCYpccLZASssBFttDTDiNN01K
         H0uw==
X-Gm-Message-State: AOJu0YxfsBsJQqX3NY95eWDZ+2Mpx0VV4L0Y6jV/3Y9OEiuWTG+qH3Nk
	12pKn1JqGSExO8jM22keK9pUzVj2ZpLsdcnoIetXSHglib25QpnJ+v555AYaXg==
X-Gm-Gg: ASbGncvHXakhEMRjdEPRmN8v8e9Ecs5hz0sPzFluIqVCi9onj4sOqZwdpq5uYloLmYR
	uveeO61nxOddVgeowowuSm6Xn4zQzfj0vMy8Kszfxt0U8h00JOrWVAe/chqZX6moXQDLjkWxpbR
	Qwweko1TNd1aN63C8YVmaws6tytelgB0ECgQDesrUBoqnTB3VnTfVOVonwbMNKf5PsEoC3mG05g
	mj0lFFAX3VYP2gl56PAAYG3lt/hZi1Fsbwrn6c2rU8kfp1wgEhzHp+cgPoqS08vku7nty3yGxRH
	A/kyGM0YdTDTJ86EESojLE9/woVO1JvnqX3wrCzM11QatnFoOlUMDeq6SOZrA8QO718eplhe18G
	2pkk4ujlzAfNdvJZ39TQcsNrut7ub2kgQQayXDQaHRxgVq46dNYxg6+YM84hW2WjRWfjO/7N5hQ
	==
X-Google-Smtp-Source: AGHT+IHrzPJcPNRh+MNIK4sYw3dxRvqkB6woJg3g1U99hYZc4dT1z27QYTALn1wgRQWcRAa97tE5Jg==
X-Received: by 2002:a05:6a21:99a0:b0:24c:c33e:8de5 with SMTP id adf61e73a8af0-27aa1f570a9mr5816411637.35.1758155593487;
        Wed, 17 Sep 2025 17:33:13 -0700 (PDT)
Received: from feddev.blackrouter ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330607b1f5esm644428a91.17.2025.09.17.17.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 17:33:13 -0700 (PDT)
From: Anand Jain <anajain.sg@gmail.com>
X-Google-Original-From: Anand Jain <asj@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] common/rc: helper functions to handle block devices via sysfs
Date: Thu, 18 Sep 2025 08:32:46 +0800
Message-ID: <512a6148be0d8da51278f94a29b959f3950bcc0b.1758148804.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758148804.git.anand.jain@oracle.com>
References: <cover.1758148804.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anand Jain <anand.jain@oracle.com>

_bdev_handle(dev)
	get sysfs handle for a given block device.

_has_bdev_sysfs_delete(dev_path)
	Checks if the block device supports sysfs-based delete.

_require_scratch_bdev_delete()
	Test if the scratch device does not support sysfs delete.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/rc | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/common/rc b/common/rc
index 81587dad500c..627ddcc02fb8 100644
--- a/common/rc
+++ b/common/rc
@@ -4388,6 +4388,32 @@ _get_file_extent_sector()
 	echo "$result"
 }
 
+_bdev_handle()
+{
+	local device=$(echo $1 | rev | cut -d"/" -f1 | rev)
+
+	test -e /sys/class/block/${device}/device/scsi_disk/ || \
+			_notrun "Failed to obtain sys block handle"
+
+	ls /sys/class/block/${device}/device/scsi_disk/
+}
+
+_has_bdev_sysfs_delete()
+{
+	local dev_path=$1
+	local device=$(echo $dev_path | rev | cut -d"/" -f1 | rev)
+	local delete_path=/sys/class/block/${device}/device/delete
+
+	test -e $delete_path
+}
+
+_require_scratch_bdev_delete()
+{
+	if ! _has_bdev_sysfs_delete $SCRATCH_DEV; then
+		_notrun "require scratch device sys delete support"
+	fi
+}
+
 # arg 1 is dev to remove and is output of the below eg.
 # ls -l /sys/class/block/sdd | rev | cut -d "/" -f 3 | rev
 _devmgt_remove()
-- 
2.51.0

