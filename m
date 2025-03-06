Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98A120012D
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297168; cv=none; b=prF/jL0YDhL7GqmsCIc6wT3AxQ2mDdfR7WdgTTV6rdbYkDk6w+1gAvsIgCoTpXbyMovgaXkMEpKKwodtsjWBOnkma0lCf5W3YiuHfyuRD9ItpdNadjEpH/AshY0lIUwwvMc/tvJeYkPMeN2C8KWQ/hwPhO1MQdjGj+kuhsKko84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297168; c=relaxed/simple;
	bh=cDjSM/x+0s80493NvDcxRGMVRpj2GTq6LY6C26I+RfU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6SLb7awz4IvbwltVaTWF3/vnrg36bsZXALuect0IKCs7DIDkKJbfGZ3vgbCEXn1jhcnIfxkrb5vjt6DxAoJMFbxZFEIJSyOmE+oWvarQOingEu3Tbc6ZDpo2uqVGDb1LBbTWSRa+YgiZBfE519MDDCUnVK/2te+E2P0w1MGUAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=l3Ub71Es; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="l3Ub71Es"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso1941843a91.1
        for <fstests@vger.kernel.org>; Thu, 06 Mar 2025 13:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741297166; x=1741901966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJ3h2Dq8/mMbPj4S1vGWnkFIqlROJaesBD/We3N4cPI=;
        b=l3Ub71EsYTwNRCJsI9Fkwp6xWxA+JgzGTjiIZeti9YZY7NLje+AYqiBlcIi6V1vrLT
         2uJ+tsHzQFFvw85Y3LMqKSXMfiIv66hHFpUho1iIcyDfPfLrLKXnBBCIMEI95OC2WDY4
         kJCadHH4eq2nAm5Nbc+0HEoO50JuscGDr1doDhll+fL/CBj1nkfa8S/ubLwgEDj9KQza
         uWXQ6oJzWX7SsjA4CKqLgVhfNetwwl+pIPtpMN0Lj/ElAfh7+O46HgDxfTZWGK6mOnrJ
         /b+GRCpdGwHxJHaL/aCtyLSFm+Ihu/DJH+y8SoVv2xuAoEMzsvxqBfrKiOScXo7d+VIG
         wJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741297166; x=1741901966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJ3h2Dq8/mMbPj4S1vGWnkFIqlROJaesBD/We3N4cPI=;
        b=hQnkaIUMg7ZucdwuKugu+e6vAEJdmRZZxHJbGcdOL/GaS5lgWW/LXLJB5byifDVHa0
         Ze2OismejueohADF4N0dBaxcJ6pB6ZsZzo2iK7x/Qo6Ow1F8JKke34NWsuL1W5yeNPnI
         B4Iv4GqZGLZK3NaR91aGjjOlGxQ8RQmdKexU/eVuA6ah4ClCHUVPZdhfVRfBZvb/VnMv
         pkfnTovE3WMrkRMjh2nD15vlt75+qYo9rRKRD36Juy4o9FkzuifK5zV3lztvVR2OjfXf
         DFxUIDSMADoEKkCE/ARApp3PZFE0zKK/NqeOBm6mTQA0WxToFlgGOhQuj7PK6dio4Nmu
         Ztdw==
X-Gm-Message-State: AOJu0YwRIIuYEJsRT3O1jogOo83E01hLDWKVs4p2ZDYHeRS5OeMiuI3O
	lE17mbl2XQsftOq+fs6CFBIZBsCfwJ/37r6kLqjxiq1hSL+/kvAYjEtQAhQwOfgsa5vgk57Ng8E
	B
X-Gm-Gg: ASbGncv6u980quiG79BbZfjiTFW4YtJfVYyIApx0hIVBVjJdHygFqBoEb1WDtazqXfd
	9426BNmnPbkSTLaBHn1xUD51o5UIUkp1mA4TfbXTNnRck8/UXs8xVlt2m3JSM1y+o0k+NKWDkmw
	yAJ2FzcjIvk/NP7QklQNCpXwuaxDa/GaxIRbkeumylfslw7ZGR6WtNW0WQd0X/90wvYDSEBjALV
	2CcaWziB2B16Zo++v3el0n2yZRz5aI+lnHlNjcFeCZUeDuDe/l/783oXiJ2YD6IUVT/pQrQRZMb
	LouVVf+daHY3zDRkjphg9OU8I1Ye/89Nq3eAtrR/C1RcyTFwmGp7cvfDxVQnLkGZCjXpO88qf9C
	jFulvEWOsQpyLFYyyCVM=
X-Google-Smtp-Source: AGHT+IGVvrMGqKKXv1eXwpJ3RAUiw4YaAd2L9hzuPKpZ1n/n78YAXVlcGsu2/HVnILOGvyUGcz4wZA==
X-Received: by 2002:a17:90b:4f8f:b0:2fe:b937:2a51 with SMTP id 98e67ed59e1d1-2ff7cf3e3f7mr1363798a91.33.1741297165930;
        Thu, 06 Mar 2025 13:39:25 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ff96esm3641699a91.35.2025.03.06.13.39.25
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 13:39:25 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tqIw6-00000009lRX-2Al7
	for fstests@vger.kernel.org;
	Fri, 07 Mar 2025 08:39:22 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tqIw6-0000000FvrN-36RC
	for fstests@vger.kernel.org;
	Fri, 07 Mar 2025 08:39:22 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 2/5] fstests: remove old soak script
Date: Fri,  7 Mar 2025 08:34:47 +1100
Message-ID: <20250306213921.3769440-3-david@fromorbit.com>
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

There is an old script for soak testing using check in the source
tree called "soak". All it does is run fsstress in a loop on the
scratch device, but to do that it needs to include the entire
fstests config/setup scripts.

These days we have much better soak testing capabilities (e.g. the
soak and stress groups, with controllable iterations, durations,
load, etc) so there's no point in keeping old scripts like this
around that add weird dependencies to the core infrastructure.

Remove it.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 soak | 121 -----------------------------------------------------------
 1 file changed, 121 deletions(-)
 delete mode 100755 soak

diff --git a/soak b/soak
deleted file mode 100755
index d5c4229ad..000000000
--- a/soak
+++ /dev/null
@@ -1,121 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2000-2002 Silicon Graphics, Inc.  All Rights Reserved.
-#
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-tmp=/tmp/$$
-seq=soak
-status=1	# failure is the default!
-
-_cleanup()
-{
-    echo "        *** umount"
-    _scratch_unmount >/dev/null 2>&1
-}
-
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-ROOT="."
-LOG="$ROOT/soak.log"
-FULL="$ROOT/soak.full"
-
-_log()
-{
-    echo "$*" 1>&2
-    echo "$*" >>$LOG
-    echo "$*" >>$FULL
-}
-
-_logp()
-{
-    tee -a $FULL
-}
-
-_fail()
-{
-    _log "$*"
-    status=1
-    exit 1
-}
-
-_require_scratch
-
-passes=-1
-stress=100000
-proc=1
-
-if [ $# -gt 0 ]
-then
-    passes=$1
-    if [ $# -gt 1 ]
-    then
-        stress=$2
-        if [ $# -gt 2 ]
-        then
-            proc=$3
-        fi
-    fi
-fi
-
-echo "" >$FULL
-echo "" >$LOG
-_log "*** soak test started (passes=$passes, stress=$stress, proc=$proc)"
-_log "***     (`date`)"
-
-
-_log "    *** init"
-_log "        *** unmounting scratch device"
-
-_scratch_unmount 2>&1 >>$FULL
-
-_log "        *** clean scratch device"
-
-mkfs_xfs -f $SCRATCH_DEV 2>&1 >>$FULL \
-                        || _fail "            !!! failed to mkfs SCRATCH_DEV"
-
-pass=1
-
-while [ $pass -le $passes -o $passes -lt 0 ]
-do
-    _log "    *** pass $pass (`date`)"
-    
-    _log "        *** check"
-    _check_scratch_fs
-    
-    _log "        *** mounting scratch device"
-
-    if ! _scratch_mount 2>&1 | _logp
-    then
-        _fail "            !!! failed to mount"
-    fi
-                        
-    if [ $pass != 1 ]
-    then
-        _log "        *** cleanup"
-        rm -rf $SCRATCH_MNT/soak_test \
-                        || _fail "            !!! couldn't delete old dir"
-
-        _log "        *** check"
-        _check_scratch_fs
-    fi
-
-    _log "        *** mkdir"
-    mkdir $SCRATCH_MNT/soak_test \
-                        || _fail "            !!! couldn't delete old dir"
-    
-    _log "        *** stress"
-    ltp/fsstress -d $SCRATCH_MNT/soak_test -p $proc -n $stress $FSSTRESS_AVOID 2>&1 | \
-        >>$FULL
-
-    _log "        *** unmounting scratch device"
-
-    _scratch_unmount 2>&1 | _logp \
-                            || _fail "            !!! failed to umount"
-    
-    let "pass = pass + 1"
-done
-
-- 
2.45.2

