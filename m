Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69244151990
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297167; cv=none; b=FyoQB2hQf3Wxg05V0kJdguve+kNHCN3YwKDREk0ak2LANJSAi35lYHA3KzQ4NI6ijEkJnwYC8iCyqeMOt8bGb4ACg8nTvLqEmrLWKUrtfeFtPrs1dZFLb4XdxyJgy0k7+OhuR7N8QHrJtBffcL+ulfdzqshNBMni6lzuabQmNdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297167; c=relaxed/simple;
	bh=N7pfLHtnj8VS+Z8BEQ8qt7JrTABrQLbQ2NnNRIgQNfo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyTNeo8z3tfFKZQCRWNKjXj7xLu3dajZKc1VWDnD9hQYFxDPalP1Cl2IrtSOI07ZtRmFaV/2iOxD5iZVG2Quhq+xX1W+LSx2G1XCfSCOqgNRuMfB+aVAeje8MOcxadXlKdiDd6CkZV5D3gWJ6ornTdPhuRph4yjui5KuUDQFJnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=RRr7UrJM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="RRr7UrJM"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22409077c06so25386215ad.1
        for <fstests@vger.kernel.org>; Thu, 06 Mar 2025 13:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741297165; x=1741901965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2KJUvO1UZidGcYTguXEMcrYZBS90tfoZ3c0LWkq5wI=;
        b=RRr7UrJMp98nXKw1EGwn2yxLC5OsGfqPU+lH2DqQPmaKljal/Nny+agJ25pc1RcrEF
         gYVF2xBVSIzYLTcpwT9bVnA3vqZIXy78E6ci8iHI3Hyom6zc2+30U1zPWzqkNIazQTSd
         SyreE2r/EH0YZGRJsCX8Um3+fyOoUe5vrolwekbyvrnSFnGAM/9oGVUiW37vgeJ0Rylp
         N4p+OGPoaUsMgYf5FJeB/vQMp3pxMhuzW+Bpcn4NFhlrM6YHdZum92GWVwaIxWneBugf
         drmP5HH9P7xSmoZviWFYwToqHfJP5u5p19px18oScOcnj3mtXoyKxHkUiw+FNMX1ye+g
         4LHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741297165; x=1741901965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2KJUvO1UZidGcYTguXEMcrYZBS90tfoZ3c0LWkq5wI=;
        b=kZrNAofV7+TKypANfL/3g2fKVuscz+gxFigd1nvEN1jJQloCDVTjzghBbTEo2wTjAe
         zw1t+rsrgbh9MeL5tuKDcNKxoeiH3t5Rd9NFZuCdg4El/utLaykZX2QcCXcZ/bhpAeq5
         E6I0dt5Gdho1eZepMzB71SXU0dHw/zlguo1/QA0qlV9KtVVILdy5i+anFIpBq4/ttPrU
         7foZy724KHkli95dRD8JPq5vOuKwVP1O0B0ls+mueJzSoZW9TKqapYZbMIJnI9SPfPFx
         qwdDDSLZrfs8cJF06pAUg4V2ou+nVxCyRyuUQw/iIIxr/rruY/U8NHhGhQREw6h85HOn
         8oWQ==
X-Gm-Message-State: AOJu0YwunK2N8M4hZkythdCzKcEFcRSt97rXfQ6umWAAfM6/FNtZJX7a
	4Wiz92GIfwVMJMwZGMi1pGEAJyS8cBr9UpovHy+bdDRYS7rfzgfPLLN9CbTU8FBn++wX7gzmWms
	7
X-Gm-Gg: ASbGncsxHdjFB822mXJn09ZGSf8gtsbfH6SW2wFyFvsiTuBtQlqAJJ9g9wCAgQSVmM6
	92Ue/FcvTnoNChjH3XMjPjuB2sVIN4LtZNRykFMiEQB2NryvDf4IfRAA2uYan0Ec1KWR909zHf4
	VW3G5FCCjjR/hzThsABTfQ9rT5bed7r00WoB6NR1qHUv+8xFp8LD/ll/1gGZvMYpTaCza5RyHoo
	mbfAwPshFPQI4rEOOuFiKKE2tHDZwXp/z2A44LKD4A744Cbuxt2cOC5cmwQltCFhGK3+BBCWp8b
	nCWPcFDwfhkPOhR2ivo2yMFf/VMge4SjaJf22/+ztTCY5SO2TjPSdZ2XQqhk7hKPG+oh2fOiPcO
	sA8Aehz0ZMytCTlBNqPw=
X-Google-Smtp-Source: AGHT+IEUdQfpbuND3N71Q+VrXfe+yInGIWQZTsp8ILqNf1gsBYdQzr2JB8+VSRgolICS13yPrkb4EQ==
X-Received: by 2002:a05:6a20:9185:b0:1f3:20aa:4224 with SMTP id adf61e73a8af0-1f544aef367mr1714834637.15.1741297165642;
        Thu, 06 Mar 2025 13:39:25 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af2810c1cbcsm1478651a12.35.2025.03.06.13.39.25
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 13:39:25 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tqIw6-00000009lRW-27DF
	for fstests@vger.kernel.org;
	Fri, 07 Mar 2025 08:39:22 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tqIw6-0000000FvrJ-2xit
	for fstests@vger.kernel.org;
	Fri, 07 Mar 2025 08:39:22 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 1/5] fstests: remove setup script
Date: Fri,  7 Mar 2025 08:34:46 +1100
Message-ID: <20250306213921.3769440-2-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250306213921.3769440-1-david@fromorbit.com>
References: <20250306213921.3769440-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

THere is a script that will echo the current setup of the fstests
directory. This is largely the same output as running 'check -n' to
do a dry-run outputs. Hence this script is redundant, not likely to
be widely used and is easily replaced with check itself. Remove it.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 setup | 81 -----------------------------------------------------------
 1 file changed, 81 deletions(-)
 delete mode 100755 setup

diff --git a/setup b/setup
deleted file mode 100755
index 375a54c98..000000000
--- a/setup
+++ /dev/null
@@ -1,81 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2003-2004 Silicon Graphics, Inc.  All Rights Reserved.
-#
-usage()
-{
-
-	echo "Usage: $0 [options]"'
-
-	-s section	run only specified section(s) from config file
-	-S section	exclude the specified section from the config file
-'
-	exit 0
-}
-
-while [ $# -gt 0 ]; do
-	case "$1" in
-	-\? | -h | --help) usage ;;
-	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
-	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
-	*)	usage ;;
-	esac
-	shift
-done
-
-if ! . ./common/config
-then
-    echo "check: failed to source common/config"
-    exit 1
-fi
-
-for section in $HOST_OPTIONS_SECTIONS; do
-	OLD_FSTYP=$FSTYP
-	OLD_MOUNT_OPTIONS=$MOUNT_OPTIONS
-	get_next_config $section
-
-	# Do we need to run only some sections ?
-	if [ ! -z "$RUN_SECTION" ]; then
-		skip=true
-		for s in $RUN_SECTION; do
-			if [ $section == $s ]; then
-				skip=false
-				break;
-			fi
-		done
-		if $skip; then
-			continue
-		fi
-	fi
-
-	# Did this section get excluded?
-	if [ ! -z "$EXCLUDE_SECTION" ]; then
-		skip=false
-		for s in $EXCLUDE_SECTION; do
-			if [ $section == $s ]; then
-				skip=true
-				break;
-			fi
-		done
-		if $skip; then
-			continue
-		fi
-	fi
-
-	[ "$USE_EXTERNAL"    = yes ] || USE_EXTERNAL=no
-	[ "$USE_LBD_PATCH"   = yes ] || USE_LBD_PATCH=no
-	[ "$LARGE_SCRATCH_DEV"  = yes ] || LARGE_SCRATCH_DEV=no
-	[ "$USE_ATTR_SECURE" = yes ] || USE_ATTR_SECURE=no
-	[ -z "$FSTYP" ] && FSTYP="xfs"
-
-	cat <<EOF
-SECTION       -- $section
-
-TEST: DIR=$TEST_DIR DEV=$TEST_DEV rt=[$TEST_RTDEV] log=[$TEST_LOGDEV]
-TAPE: dev=[$TAPE_DEV] rmt=[$RMT_TAPE_DEV] rmtirix=[$RMT_TAPE_USER@$RMT_IRIXTAPE_DEV]
-SCRATCH: MNT=$SCRATCH_MNT DEV=$SCRATCH_DEV rt=[$SCRATCH_RTDEV] log=[$SCRATCH_LOGDEV]
-VARIABLES: external=$USE_EXTERNAL largeblk=$USE_LBD_PATCH fstyp=$FSTYP
-	   large_scratch_dev=$LARGE_SCRATCH_DEV attrsecure=$USE_ATTR_SECURE
---------
-EOF
-done
-- 
2.45.2

