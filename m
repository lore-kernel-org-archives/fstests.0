Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3464689
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683553; cv=none; b=JiDENKtpwPzRlsGkooOvVi77jOgr952WvB9F3CauVjefM+f5z+C/DSKIg/OekTHX0B2NzkM4x5FRsHpcCBKG8rfWpNuEUVtdGeh1o3o3/MtumHRdkR81zSfgOGDzG9t/DVopdVaZukjwvlDc/wiW1IhhMd/HssvHJTlDIbziW3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683553; c=relaxed/simple;
	bh=bEWIKywlAbVNUj7Kq4YB68KU4RfpC7bLLiZ6fMXZ4aA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/OgU2kE6tvHp/okQ38IGCndAkCrfyb0TUGM00P1NZuE648f+bFYf0qECw16GsmX8jaSMX98oMwHgLl76v77hKFsoHne2CV5Usv0rAhDNp5cYetYN84T/gvbWRCbwrODrVtMWFq6AT/GxlumLh2dDhQ/PxW5jRfAOELskXBto4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=JHjg0pT1; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="JHjg0pT1"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ea499f264fso324406a91.1
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683551; x=1733288351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcV6O4rEnXb85dFkAiZQFzOKmP6sjZbfBJHSKwxpnm0=;
        b=JHjg0pT1Pb0VkmSPBIo7TwdzgQU1nLS6YOJ/M4G7NBUSMUa7BSzAII79ojD9zd/OcO
         S3Xw42qu2dSmEmbZ0DYaTmpr7XBtwGZodZvUAsHzUJ9fg2l8NkEapVm6EAbH2BoYOhRi
         /MEFg/QdDAEbAloOcGZpppXdpjcFlMymjjfWEqm6+0dlwUt0mmxXDiMetxRz/SwAj4nm
         vwEwZT9kmwpr9vIWc0AVYs4Mxtn0DwanYt3SaCMB3xCnT488/DcER0PMmg5Om/cftqAj
         FAjk+9tJVOWg8Lx/mpYISbaW5S48I0YM5F63CC9i9lCxDd5m8oNDkV7oA5ugkqKClkEW
         BYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683551; x=1733288351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcV6O4rEnXb85dFkAiZQFzOKmP6sjZbfBJHSKwxpnm0=;
        b=IcNZ9WWw6n/WpkBuRtJ2furPVeP8t7jprBSAz/+Z/Q/S+z3ZAoTpysY5fpuMCW1nOM
         vqaEB+qvNM/tsahApKBiOk0B+IxvAEtobRRoHp9gq1wrbaojuxQ86CfrkaCKQL4x7dNq
         Uo7tIJbtR7kGL69ZvovOzaQLIHzFuwmCK+dUQR47O8JjQ/us2YkPc2DIe5mwEgzn9cSz
         NZogEpGTBClgoRvyuXu23unCeXuQoBo9h/fxlmBIbIJf/WM0kCm1hlVLoR0AJEqqi0ii
         Qk37j21OXJ+frEO4lcBpSYWurPnmU5bAefhUYzlNQpbNOnAHBylf2356tzazXywBEFFg
         DjJg==
X-Gm-Message-State: AOJu0YwgkTkbExIUcUmun0cbI7CHJRYBOPSpa4iIVCbLt3zosKKyrTml
	Hb1E1ExJnQZ/zcfyjmPpS1z4afgOt0v7Jd7QgtVzKdRyM/84grujstqU/A3OljBIzAvBSD72PYU
	M
X-Gm-Gg: ASbGncvRKwBStyIDcaQntTXlRRYJN9OaQCfIbTanwRE/AFUeY36bobrUuKiDTlerSjW
	XfTqmgkVYPatuYXZ2EMq+i17QbJ1MRWJpv3fwFV/SSadpMPeRgyHd/H8uDzCoAMr6hNu2eNns3/
	+YzNSeaAnDJI1GIF3aTZANoH8PuWBZArE8gsU3JZBTIPrziOo8mtOVvxS1VT1PL7t4nNu29QewZ
	IgVpPEhUcVLTUWNqytMJAYhMa2Z7FyKJm3rVfvfmlB5loWj4JNPkqBIJUYj73zLSzEdYHxTOMnT
	Eo9DsGL5HtVILA==
X-Google-Smtp-Source: AGHT+IF/UoY7lWhBwGx9YnpBXPxwazFF80LQzo297Y7ZfPLgq1OCnsus6YTnNT3uDHWL8IWeode17w==
X-Received: by 2002:a17:90a:de98:b0:2ea:7bdd:f320 with SMTP id 98e67ed59e1d1-2edeb68cf73mr8721573a91.1.1732683551119;
        Tue, 26 Nov 2024 20:59:11 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa66e87sm496374a91.23.2024.11.26.20.59.10
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:59:10 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZVw-3oI4
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3y-0000000FQg8-07k3
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 33/40] vfstests: some tests require the testdir to be shared
Date: Wed, 27 Nov 2024 15:52:03 +1100
Message-ID: <20241127045403.3665299-34-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127045403.3665299-1-david@fromorbit.com>
References: <20241127045403.3665299-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

This ensures that these tests will run successfully when the
parallel check infrastructure makes all the scratch and test
mounts private.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/589 | 2 ++
 tests/generic/632 | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/generic/589 b/tests/generic/589
index b5860070b..0384083bb 100755
--- a/tests/generic/589
+++ b/tests/generic/589
@@ -164,7 +164,9 @@ move_test()
 	move_run unbindable private
 }
 
+_mount --make-shared $TEST_DIR
 move_test
+_mount --make-private $TEST_DIR
 
 # success, all done
 status=0
diff --git a/tests/generic/632 b/tests/generic/632
index c7a1f1fad..c4d3555bc 100755
--- a/tests/generic/632
+++ b/tests/generic/632
@@ -22,8 +22,10 @@ _begin_fstest auto quick mount
 _require_test
 _require_test_program "detached_mounts_propagation"
 
+_mount --make-shared $TEST_DIR
 $here/src/detached_mounts_propagation $TEST_DIR >> $seqres.full
 status=$?
+_mount --make-private $TEST_DIR
 
 echo silence is golden
 exit
-- 
2.45.2

