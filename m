Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36E113CFB8
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683253; cv=none; b=Ra3A8hG7pn2qrmKnhq8fLB8+tJUeZ+RSw50aMdBRbkto8+ZfUk5N8L6Qz46a5x1kMfK6p6UejYckw+kVALf9RA3kBouUIhuLNMfl4M8liSMfYBWCMxI9jFX+nD38FWWJg/4OsquRPd4acm+KibRZ44BrUajLlbjiA6k9W6rJf00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683253; c=relaxed/simple;
	bh=0vTE6IWNZia74SrWsrPk1ISh7bGgWmOszPA3IJNmm0g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J84welPmnvzvpVQ/RmpFnqbUOCTviCvAu0xpvuH6p0nEThHZFA/dVx7Qp/DQ2/9QUp0tZtPT7U1VGs8LHM/D2Jhp3WBNgHOQsxSbU029oMXgAJQexU6nbpKawvMQdYL7vcUtSp6umEVLcq4phYe71jenEZ1afJSjAIIZ6JkNIfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=KN2xD5gB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="KN2xD5gB"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-211fcadd960so43155905ad.2
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683251; x=1733288051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uwAK2eRmz4IdUCzekThmIWw4rKmIlS09JeZMdVd3kWU=;
        b=KN2xD5gB/3vBn82bKMxGlIk5Op3HyzDDqn0WLp+9ykZkG2o0p4YLhPH5QJ7b35puDX
         +kNuqun99Av5ZwRlms+tVgXqB6AWGVc4RCScEMBRnxGbKKhwWCNT6r+GMjr5vCFFMx9g
         aRAZZ4kiPqkyiBlaimvzININ3uncAxfsH35yGPbZ5TRANwPjZ3qTyER73sgce7ZfyuO4
         m3SbMy5D6Ley8u7k3tiBeTxXnjnE++uej9nXvu/1xTFvquyeJhsYiufia6Z1cSDZtbB8
         l8/3sXcjJdSmsuRaIGH2su+XLm7xTWIOkPNL0A2Vg1lVvjDaCTjkRNr/GHDR//uL99jW
         uwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683251; x=1733288051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwAK2eRmz4IdUCzekThmIWw4rKmIlS09JeZMdVd3kWU=;
        b=PdwPiDE12sftmVLqeQIxbxzOB1dGsJGd3nFPeJlSWMWVVZjoh4L/VWv2WqZ92y+0tw
         oxd/BybL0T/RsKVvjeKnBBN+El9ef7iWKXOWmkx3EwDSZWHHEvIjc/xj8G03SnXyzfmj
         AuXkeAwkl1xOuiO620Vx8CVPIqV6nswge7qm9FHgKScuUxL9JXUJp7PTsdoXxLr0ux7c
         kHj7LopkusNlkeInLbSD3Og49nS19aBIMVpKC+313VpKnlPlxa1DdC/QvstxNMBpe/Mz
         3XZlZmVYCENecEeQMF88fVzJHxowZGkdjcrq/48cg7aTUSj2z0beQgxm/3dQtplpgZT6
         M3XA==
X-Gm-Message-State: AOJu0YwtcV++hx0eBLYexTAF1uiI1B3vtpwYUkS/+HFTW1XgfL6lE4R4
	9FCJtrpqM31xvbFWlGcU7an4F4//zGd4eK9XS9J6ejIzdtekVKBb1p5VPcK4b9rgOPKSvvUPPl4
	0
X-Gm-Gg: ASbGnctj0fTlxdDhEmgXMLsCv6GyAO1jBandoi/2dYaLH7iotpW//lxlmZEg2KjaSoY
	vytNTOVJCqqQGSS7//Ubu47oGhKhIoUyw9MJoenxSJ5g2PNhlZzo18vxlfzMBxtYGL8waDD1OaU
	ZMdtoZsTCox00v7RyRofA/3lsAu0lq2kMrEIESHOM0PXq3L3PsjDtbIBEv6JPSYxGhswYEUmYol
	r9jA6Zgni8DJVgyVvipgyyuWvAt2jHnWiMypz3Jl8u/JCiUonVvCc807ppSfNOKk4rrFjewYqfh
	8/rXnOJOJFggggZ1OgYRofzq
X-Google-Smtp-Source: AGHT+IFUKxEz5k5cb1KHi4MkMsUdM0Qh4hao8ZmDV2fYcXKV9frIb52rxBonPWBA9+Llo/QeGjya8w==
X-Received: by 2002:a05:6a20:a10f:b0:1e0:cc21:19a2 with SMTP id adf61e73a8af0-1e0e0aaf55bmr2973800637.1.1732683251214;
        Tue, 26 Nov 2024 20:54:11 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcbfc0886sm8321827a12.2.2024.11.26.20.54.07
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:54:09 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3w-00000003ZUL-41Fe
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQe4-0MCX
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 08/40] fstests: per-test dmdust instances
Date: Wed, 27 Nov 2024 15:51:38 +1100
Message-ID: <20241127045403.3665299-9-david@fromorbit.com>
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

We can't run two tests that use dmdust at the same time because
the device name is the same. hence they interfere with each other.
Give dmdust devices their own per-test names to avoid this
problem.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/dmdust | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/common/dmdust b/common/dmdust
index 56fcc0e0f..37bb865c8 100644
--- a/common/dmdust
+++ b/common/dmdust
@@ -4,12 +4,14 @@
 #
 # common functions for setting up and tearing down a dmdust device
 
+export DUST_NAME="dust-test.$seq"
+
 _init_dust()
 {
 	local DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
-	DUST_DEV=/dev/mapper/dust-test
+	DUST_DEV=/dev/mapper/$DUST_NAME
 	DUST_TABLE="0 $DEV_SIZE dust $SCRATCH_DEV 0 512"
-	_dmsetup_create dust-test --table "$DUST_TABLE" || \
+	_dmsetup_create $DUST_NAME --table "$DUST_TABLE" || \
 		_fatal "failed to create dust device"
 }
 
@@ -29,7 +31,7 @@ _cleanup_dust()
 {
 	# If dmsetup load fails then we need to make sure to do resume here
 	# otherwise the umount will hang
-	$DMSETUP_PROG resume dust-test > /dev/null 2>&1
+	$DMSETUP_PROG resume $DUST_NAME > /dev/null 2>&1
 	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
-	_dmsetup_remove dust-test
+	_dmsetup_remove $DUST_NAME
 }
-- 
2.45.2

