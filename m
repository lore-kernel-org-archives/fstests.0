Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0680286D5C
	for <fstests@vger.kernel.org>; Thu, 14 May 2026 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778788827; cv=none; b=SaJeGRwPMf8Enrmo7B9kDamwJXVLK7pF6ZR9f3plxQivOaQ/knnyJPBwMilDhaiRWqzhMW1unk9Gru6Ume80cR/U1HtUoggT/B0XJBsl8K6L+zN9IU/TuPgIRTnHmpx84T8SckQL/pvmwAKRJVdWGzmhdR/yOSKryXnczXR+ur0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778788827; c=relaxed/simple;
	bh=bTMlax/8913IiPWeFDZ7nqT5gax+kV3Ndhhz8UGryCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AHNTyMFAk9uYZ/VqbUXHkKIonjmxbVHKou9E0Vmcx9uL8FRVgI0nPC7LNoT3K49NFu1VltrzDbdBxn3QVAOyTDh6E79Nd5fv/h2sixYGbUldkYi0YSByC6wibf0bUsj9fij0rF0ck/8k86urv4XjCvpKKC5eHq+5Db9XsfKFqIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=qkDUHeay; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="qkDUHeay"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-656d749109cso6326166d50.3
        for <fstests@vger.kernel.org>; Thu, 14 May 2026 13:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1778788825; x=1779393625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sQuoEbtw7niw9BnkPVOKSPzKXN3bjsS4Ug9OsTAfSUg=;
        b=qkDUHeayiIkE34yYsR2VL6noFFVq+Ve/3Vv11k/kgWoALarXnwUT8FwZI7tPsc9+3L
         vDwLsVAMHPP/5HGP2SJePy+38c2LIieDOod6YwYoy/6f8KUyiujZLISBmfWE//DoKxP7
         NONdlSqUSXENNL53hAa/DmbB8iLh2uwpbIZwkZbX9qvJVVSdTmaBmElgaCHrzm/w0bNG
         pLLhsLaMQh/jYWK+uiU209Uw7dycl4V7/0jru3K9pbWRQI87kyA0+R4HtQdaDmdLLmi2
         x48jpcnwRp8j7ikCk9pl3PVnAVqUZLwVATFfuvIhOPcNpJ+kGDAK2kMVwDNLBOJ4zATI
         ZcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778788825; x=1779393625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQuoEbtw7niw9BnkPVOKSPzKXN3bjsS4Ug9OsTAfSUg=;
        b=VvEDUPUAqN0roJBxQdQFxbjrpTwMzVGppsh2bBlxZyBDzJyqsAff4bfcCQEquqKqTV
         5UMFSjbFM1oTTGHKIT9i6yrdxp2KKWJ+VQEhoHJ/r74tEYURjYDLdrihgB99HtRy4j/P
         SBAq/E3UGgfCQPQkmOMSFsr6vFbekic1DFLvKyGNjf1/QEvkbHjPAutDUJRCSz4mSJMj
         /vQALgragyPz4sOns38h8wAP2chMbp1bayBALMd03VZv+3E6pYhVmOmUK/K9XrFsl7uw
         pUTfvoou8ivkLh4i6p24nCszFQZvUVMmTWju+unHUP5e/sc1qg/wG6dVN/bTPf+mHSOy
         KXYw==
X-Forwarded-Encrypted: i=1; AFNElJ/pH/LpuO2hyAmZVS3sKFLySlZDR0naiNmq6kwraQdZNeTst00CIWkLRXeBRjfIRFl742L23O3c@vger.kernel.org
X-Gm-Message-State: AOJu0YwHiJN2wNioY6IJdrl7DdK0IuW5bXQFLo+I9SuHJMdYaD+ZI8Jt
	SDwAFCmhWRnXWc6j67nfXeYh3DUI0C8gbdY5MqcHoduRnSmy3EDESLWghwEOlk7FkAlldMjTwv8
	mtLVuG1M=
X-Gm-Gg: Acq92OHIkR7hpXqQinDJv3j0PuH+gyOESDy+IhKJpMEw+Qs6YyN7l+Opw7sHIxEfRgF
	3GdLn1KajDF8tE53gWEQewH1/xwsi7mbIVxEJPlypVxVDZgtTxJ3vjUzoWpZPQ3yZ/LzzGBo11c
	tvYjF9TfRWhTPZQkTmnN8m5VflR2mdAOo93nTmEQLBrXEIRGQkaka61B+lQ827Jcv0P7LMIXVeo
	zz7Cdftrr48XDKSYv0h1DFJ6J8df3ZC8GPurjrTHTJCzM7ZMLtF3ot3mx8mqx/GoYgT77B1fBZL
	X3yLVmWBwihUbwaez1zY98o+VgMznSFU0Lg/eKZpqK9gd6jvqHPSM6vGOHW1wbXw7dK03X5ZsJI
	2DnMAj2HDxLDKTQrN6lxSqLGkIyovDjvxHphiMdpMJTT6X+81hfuFmQMMKVHvFVg9uWqtSuPIgJ
	k0cvQpVN7CBLvuoDksDCs7em3Y0G7cqDNuTXSDgdKeSuTqYIkdENyutqmNKBYommPlDY9XCpHHp
	1hgzvupzLndUbFnGaEEEg==
X-Received: by 2002:a05:690e:1582:10b0:651:b593:d3c9 with SMTP id 956f58d0204a3-65e226dcf85mr647551d50.17.1778788824453;
        Thu, 14 May 2026 13:00:24 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:1475:85f:92c5:666])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db0b134sm1542771d50.13.2026.05.14.13.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 13:00:23 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: zlang@redhat.com,
	fstests@vger.kernel.org
Cc: glaubitz@physik.fu-berlin.de,
	Slava.Dubeyko@ibm.com,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] xfstests: disable generic/003 for HFS file system
Date: Thu, 14 May 2026 13:00:05 -0700
Message-ID: <20260514200004.354432-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HFS hasn't any field in on-disk layout that can keep
the file/folder access times (atime):

/* The catalog record for a file */
struct hfs_cat_file {
        s8 type;                        /* The type of entry */
        u8 reserved;
        u8 Flags;                       /* Flags such as read-only */
        s8 Typ;                         /* file version number = 0 */
        struct hfs_finfo UsrWds;        /* data used by the Finder */
        __be32 FlNum;                   /* The CNID */
        __be16 StBlk;                   /* obsolete */
        __be32 LgLen;                   /* The logical EOF of the data fork*/
        __be32 PyLen;                   /* The physical EOF of the data fork */
        __be16 RStBlk;                  /* obsolete */
        __be32 RLgLen;                  /* The logical EOF of the rsrc fork */
        __be32 RPyLen;                  /* The physical EOF of the rsrc fork */
        __be32 CrDat;                   /* The creation date */
        __be32 MdDat;                   /* The modified date */
        __be32 BkDat;                   /* The last backup date */
        struct hfs_fxinfo FndrInfo;     /* more data for the Finder */
        __be16 ClpSize;                 /* number of bytes to allocate
                                           when extending files */
        hfs_extent_rec ExtRec;          /* first extent record
                                           for the data fork */
        hfs_extent_rec RExtRec;         /* first extent record
                                           for the resource fork */
        u32 Resrv;                      /* reserved by Apple */
} __packed;

This patch disable the generic/003 test-case for
HFS file system.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
cc: fstests@vger.kernel.org
---
 common/rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/rc b/common/rc
index 5fe44e21..b897ef0b 100644
--- a/common/rc
+++ b/common/rc
@@ -4559,6 +4559,9 @@ _require_atime()
 	ceph|ceph-fuse)
 		_notrun "atime not maintained by $FSTYP"
 		;;
+	hfs)
+		_notrun "atime not maintained by $FSTYP"
+		;;
 	esac
 
 }
-- 
2.43.0

