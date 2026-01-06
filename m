Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5EB19DF4D
	for <fstests@vger.kernel.org>; Tue,  6 Jan 2026 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767742582; cv=none; b=FvdIaz6EeOJ0AZMvlTlPPxiSbWV9tEKcxI/FAXAARqqwqtvEd2sPwopxD3Rtg0emf0S4r7Bzfn1yVERhNT9Z6rDQnpKpHDGitt3R0Y2Emf6ClH/9d3Fp1KG67Nqcmuyf5JKDBhtEstbzGTohAVC+Gmga2EkbOr1jS86f3kX4Hd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767742582; c=relaxed/simple;
	bh=IOGXyKfRAtQgkCQsFi6glUXjNoElbj9x16QGZvKR9ec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SXJIHJIpwZUwjZ49gsg9zldRMI7Im/SR+sz/VoUcx4l+KK2bYCKb5WSUa8ADnSvMBsCC+bJQVPgsuqBDAPH/to1EsRM4r1AnmRLLAbfeW6XNn0m7oy/V9yq4Y17/J7q4KTDoMuDv9vi91BH8J42oCv4yLZq9jf4EQl0qNq1kvYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=Hhs6cudN; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="Hhs6cudN"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79018a412edso17109787b3.0
        for <fstests@vger.kernel.org>; Tue, 06 Jan 2026 15:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1767742579; x=1768347379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P903sGCFXcIuyiG+MFuiGvGYJlxu7DOENj1XsX+4lW4=;
        b=Hhs6cudNrVhmRvEXg6CAeebE0gmLs6qn4+Nj+c/eQkBWD7ANffZ1KpUmF8xdQXCJSn
         qkmeiM3NC6hYxHJlQWNCtzuO1njzqWm5Wm1OT8z0h124Acd5C+A9n+Z/H23ii1LTh7kf
         Z1Gi1QyDSLoC1OUKUZ683ALUqSNdmPBcAl0lyqBT0LlSUDcb0W/sRDrBvkdAaiZvgtn+
         Fn3RwWcxR8bGO7tBZvjbYWMaF6w8HhGm4hmkKEqkoH5kGpe6WKn1PNTtH2jC9n5MlKnR
         zNRiPWvFL3xb1xKZANsQe21tnyODPUhf4vxF+dBfPdcgJvzn2u4dPP93RMIDV/edZ5RU
         67+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767742579; x=1768347379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P903sGCFXcIuyiG+MFuiGvGYJlxu7DOENj1XsX+4lW4=;
        b=Dp8JT8IPj4lo3HsNxjcnPSaEQHCRs+szQMQGNMVKLlpSKEiqiIMHLMTlMme3m7FsD6
         9Uz61CbcqH+mRl0vTOIsouA28yHhaD4tHzb4lcaevTTPR/OtdUKiTNKR7TwvH2wsXEay
         80WBtW7xZC153ywBSOslLVKGSL4xmAVKcSMSI757qkjvwCoDBWx8TbvVjw4Cex0uwTzT
         VkCjO+FC4ScTjA8MRP/gBoQ+nxBDKVInyOsu0f3wsh9WG++nj+dlTyJHOIwcUKU68M4q
         FZMrUrr5h3Saxgygjc3HE6EwJhhhm3k22zEaOL1zUm1B0uAYsMMqJaC96xtG2+Ui9Tau
         DCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC9CRt4ylR2kMZfd55BRsUVBcwDUqh9C11PXNwv7dKQtOWAgLPigccGWEh7NI0It1LkoTxOKI/@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJB92w6gpwyuO6ahWu+IR9vqc2TfeQaaYKaXprUi+eL5ljXfz
	OjaITanUzMmj4Ba75k7TpIehqjy3yhaBwXBbtHEICZ9xoRexmB1T8PUvzBmR1bA3VfM=
X-Gm-Gg: AY/fxX4OeHh408Blaq/nIWb5G2dYo7g9ohdaoHtXIjB9aP74pmZpS6juZOKk4xtE/m8
	UVxxUkgo/R4AMpqJJsiV88dajSfwAu+39kGO8geKaGAMY0IcKfxY/lPlMQNRSfYcHxV9wkilgHW
	OMtnwCrEEH5KC79c4IPPix+kLRmQF9kMuAaqX/SMOEReRkibTSbUdqTEaHAPI8yBXtiQXD/sxtf
	jzV4LEQiqhdxOGaJSLg29gkmJaVsNX4XlZv5gcS8U2tO18NE0BgoQxzPiGxUXF2wpMQe1wiKfGU
	XIAjgaosow6IF0KELj2oEeDh3+6KHjrbhVahNLuP6yO85IGlJAcqgfCAiXVOG+z79I2JCiugqCb
	+Nu3z4QlaSfq5BYla46qSmTq7GSGasy/J+3VqP7CIf063fYYL9qTbn6VKzQyCLpXOE9KffOLH+7
	E0on4ZuuBnRU9RMAISxj6m4p10TyK+7T/Hz4pwOoUZ4oexBjxRUAGEOm6kCBYzB50v+Tdseg1d4
	q6XHKV4UmPVPCZiNAUDX58=
X-Google-Smtp-Source: AGHT+IGGrnRIngS8B91uiKhP8B+rtLRAgmEqeRLsRN/E00Rq6uOZNjkNxxJuDcm5aZr0O87LJ8pg/A==
X-Received: by 2002:a05:690c:6104:b0:78f:8666:4bb8 with SMTP id 00721157ae682-790b56d503amr9297877b3.55.1767742578835;
        Tue, 06 Jan 2026 15:36:18 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:e046:4528:3155:2351])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa42544csm12965327b3.0.2026.01.06.15.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 15:36:18 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com,
	fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] xfstests: hfs/hfsplus don't support metadata journaling
Date: Tue,  6 Jan 2026 15:35:56 -0800
Message-Id: <20260106233555.2345163-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HFS file system doesn't support metadata journaling.
This patch marks HFS file system as not supporting
metadata journaling in _has_metadata_journaling()
of common/rc.

Technically speaking, HFS+ is journaling file system.
However, current Linux kernel implementation doesn't
support even journal replay. This patch marks HFS+ file
system as not supporting metadata journaling in
_has_metadata_journaling() of common/rc. If journaling
support functionality in HFS+ will be implemented,
then HFS+ could be deleted from _has_metadata_journaling()
in the future.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index c3cdc220..82491935 100644
--- a/common/rc
+++ b/common/rc
@@ -4267,7 +4267,7 @@ _has_metadata_journaling()
 	fi
 
 	case "$FSTYP" in
-	ext2|vfat|msdos|udf|exfat|tmpfs)
+	ext2|vfat|msdos|udf|exfat|tmpfs|hfs|hfsplus)
 		echo "$FSTYP does not support metadata journaling"
 		return 1
 		;;
-- 
2.43.0

