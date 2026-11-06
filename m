Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980716;
	b=kh/m1clHzTdRDGYAmBXKIXvQN5EPj9cQE2HCJOlVBwvJJ8QajE3HfSewCCr+xEVpIaIF
	 IK1v+LE4SfuMivJvgEXUTmLhhCd1PrDTKoXx9YuESts2dd1B/ihBsylJPMyWRcumzwByH
	 ixUUOvhf2Bn5waOGa60UfNc/Nf3loO3fnQxYw+kcs/DVT4wGuFP2WVbR+T+XRRmLAzBg1
	 Km15mr0ocPA2MBRRZFZbhCaLS8ntsOOo7WyvcJ3ZNeK/y7WGdvb1F4GPLVG6ax9imXORL
	 debYld9gnjozTNZfC4aUtJQ9AcpRASV2jBWIBSHmEjt2H6HtF51jPXsghw9raLJezqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cnSzx+qXkdANiqDPEgHBYZwvlAI4prsezrDn8DaI04c=;
	b=YHll+uc2yQyfxiwSfzmBj/kQB5fq/NpAmX03cQA4V07puDKX7uuxFnleVrzHQPNUsrD3
	 3sRqwpLdYw0Kj9w6g8Nv/lHTmGFGmHG11rDpMPMw4/y+pZdYdWH9HwiFUFm4jsv4fqd5D
	 c3sFxHEY1wLlCC05JexjK9KXAixhvQ695g6Kcx4ahfPf0cHrVSX5zw5FLPWlw1PTr2gr+
	 iF4WJHJyJk/5EM3Gp5EJebOE1Hj9tw7reNjsbDTuv5yTIAzNt4gQsEqa/odQPPoLx3zUQ
	 QKy59S2bykA3uBzfaf42o1OFDjv21sVMhwXzz5O6f0SyF5jA620ne7rG1y9lgJOgaDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="tNra/hYB";
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ED2606A32C
	for <fstests@vger.kernel.org>; Fri,  6 Nov 2026 15:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7ED2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tNra/hYB
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b6f42095bcso310155a12.3
        for <fstests@vger.kernel.org>; Fri, 06 Nov 2026 07:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793980714; x=1794585514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cnSzx+qXkdANiqDPEgHBYZwvlAI4prsezrDn8DaI04c=;
        b=tNra/hYBuobepJ6sCsGZKHB/Qx1EC2/iWfLLdQp79AS0zJyM/o0+8H2r4d/d5HsYhU
         57TueAzyxgQBHIpWSX7Pi/ZVWkxoseLhJ+vuGw3mQSMRMgV+JBztK46AHmrNCW2v11XG
         xFtXtKu40VN122xkLLAHk7eA7Dfo4S2/jv/XpLHu9dL/el/EL1xncp/XjpM3QIBAteTo
         c1BFDk4vYDCblwR59SrwMPlSoPijcE3lLM+ZPZPAQS6U5I4e//cDPAdRYJlJvTr1962E
         Gm0DwlVt2stik08VVsHNsFkx0ezd1bDxCADXp/W8oyayNwYOe7PtOo4liKSMZ9ivBDWg
         5pTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793980714; x=1794585514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cnSzx+qXkdANiqDPEgHBYZwvlAI4prsezrDn8DaI04c=;
        b=HVbTaoiOYYGh5MRR1wyP9kAeJiLEBnIbXdxFpjMu++udMtNVwWYfDlhnzdyIi2yvkj
         aYHGoQsuuuSdRMYmf7WVYB9HNJI0mWs9CXSs9LNbK7k316SRl7PJJuQlfDHb+YA4gIle
         rdZuuXBXEz/zXpKZrDDbHw8Noj8HOww9mdewajyu+t9x38IQWLcrusEg3o3u+Ar9PFQK
         uwJxzW6ZUiDJ7XAOFJ+W3YslUCXTXzqIzxUgm74SkrJ9MDaIGAsC7nnc8PiT6uXyy4BJ
         u8Ym08j/g+DaKYf1WQPblQQ4TdyQJ3LCJz8J6gqcLArGdeG2Z2diN+gZ2pqKdD2rJ02D
         QdEw==
X-Forwarded-Encrypted: i=1; AL+hErHMy6nZC40lD4HoSsh0Vvi/F2wm6jBPF/ke7pcC/iNGqwcv3bGL8YVCRr32KzF1M/9Y4iTiuX9f@vger.kernel.org
X-Gm-Message-State: APuU4Z+OHo0jHIj9jsHuKfyZwtEdnwdtkphmOi/muSnID/uCwbP/XTHX
	AIznRjdB6NtkF2gLPdDBWrbttxR2ILK4KnfCpTmI0lNixfdUZ3ZGw8Ne
X-Gm-Gg: AYBFou0l88fkWkDB88VfBTeTontfqzy3FEmj9EX6EPqEBO3z5nPgkl6Ep6ZSNcct00k
	ixQEFWUaIh5AZLfrZfrT/+hDFXV3jOSCyF5zK1RdQ0M3JZwgP2WzGmu8Pr7ytoDRz03eP1puOYZ
	WMTowW8BUymZ5PwdW0EElX+bM6MmTw21Ms6AWqLnK6NX7T/Rns78HyyZVtIrplJLs0aMb5B1ojc
	ynR5xhN8zCEFMlz2zjw59wdIDXjYwOBfHvCI1GnWg49h675AxalhmybZfb8sYwaytVmpoxxpbEQ
	av021Rti6D4osTzboWPj6oBpFLltCOe2KyVWj5E98IOzQqlJ+MBKSqIOFfJEWWGlWi/CCM+wXuS
	6lHsSYPaAiqRROO9U6IR4n+kQ3ThkTBGN7lhcCcDwkbpkF+Y5N4Cvxi885TXldxYoJboNyO8nl9
	tZfF4Mr0WXHQ7S7n+w+i4cMShr8uJJwVb2w/LD86SQSwGzKgNaXmJl7RNyjuU2GGhLaX/Kh8KxI
	sAuKsw+ti6qa94HyHcIGxANy3ZPmg9yJWYAxa5VnjbQLjS8OOu5B5uYLirhQzP2Dipj9BQAZ4yA
	aOKL04QCxl0tmMRkJRJxTTXqI1KCETwYZUC5aQS7LsvMAN+e9LT/LXPhjhhC2U3+0tA2PbFTF4Q
	e8dXQNwvSuYs=
X-Received: by 2002:a05:6402:2111:b0:6b3:dd6e:3dca with SMTP id 4fb4d7f45d1cf-6b5977e51e2mr2276657a12.28.1793980713953;
        Fri, 06 Nov 2026 07:58:33 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b669c4c240sm852689a12.36.2026.11.06.07.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:58:33 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Zorro Lang <zlang@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	linux-unionfs@vger.kernel.org,
	fstests@vger.kernel.org,
	Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Subject: [PATCH] common/overlay: fix _check_overlay_feature for default-on param-less options
Date: Fri,  6 Nov 2026 16:58:31 +0100
Message-ID: <20261106155832.3867017-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Overlayfs only displays a mount option if it differs from the default.
Commit 73a018cb treated a feature without a module parameter of the same
name (e.g. xino) as default off and required "${feature}=on" in the mount
options.  On a samefs xfs setup xino is on by default and is not displayed,
so tests requiring xino (e.g. overlay/041, 043, 044, 067, 070, 071) were
wrongly skipped.

For features without a boolean module parameter, assume the feature may
be on by default and only verify that the mount options do not show it
with a value other than "on", same as for features that default to Y.

Fixes: 73a018cbf57b ("common/overlay: let _check_overlay_feature handle param-less options")
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 common/overlay | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/common/overlay b/common/overlay
index 132b2bf7..0cf6db2d 100644
--- a/common/overlay
+++ b/common/overlay
@@ -172,24 +172,20 @@ _check_overlay_feature()
 	# parameter (the system default) and per mount by mount
 	# option ${feature}=[on|off].
 	local default=`_get_fs_module_param ${feature}`
-	if [ "$default" != Y ] && [ "$default" != N ]; then
-		# Some mount options (e.g. uuid, xino, verity) have no
-		# on/off module parameter of the same name.  For those,
-		# a missing (or non-boolean) parameter means that the
-		# feature defaults to off rather than that it is
-		# unsupported.  Unsupported options are rejected by the
-		# probe mount in _require_scratch_overlay_features.
-		default=N
-	fi
+	local value=`_fs_options $dev | tr ',' '\n' | grep "^${feature}=" | cut -d= -f2`
 
 	# Check options to be sure. For example, Overlayfs will fallback to
 	# index=off if underlying fs does not support file handles.
 	# Overlayfs only displays mount option if it differs from the default.
+	# Without a module param of the same name (e.g. xino), the feature
+	# may be on by default, so only require it is not shown as non-on.
 	# Overlayfs may enable the feature, but fallback to read-only mount.
-	((( [ "$default" = N ] && _fs_options $dev | grep -q "${feature}=on" ) || \
-	  ( [ "$default" = Y ] && ! _fs_options $dev | grep -q "${feature}=off" )) && \
-	    touch $mnt/foo 2>/dev/null ) || \
-	        _notrun "${FSTYP} feature '${feature}' cannot be enabled on ${dev}"
+	if [ "$default" = N ]; then
+		[ "$value" = on ]
+	else
+		[ -z "$value" -o "$value" = on ]
+	fi && touch $mnt/foo 2>/dev/null || \
+		_notrun "${FSTYP} feature '${feature}' cannot be enabled on ${dev}"
 }
 
 # Require a set of overlayfs features
-- 
2.55.0

