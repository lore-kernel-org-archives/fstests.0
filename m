Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2A413BC35
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683260; cv=none; b=TA95G2+5Jm43oCOO22F0nkU689+QfT+fMsVKWuAGCD6VZsZKy9Si23FlRXbn75epwWpbKm0QYEaHhuVam2ImGblpff7kPzTMiuJHvU8TOvCGOiS0d5wOqGqp9aRTtAsawOzPXoZK0gs3u0CoJPyyZ5t9MtBHO3kDr/r/8xxSMCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683260; c=relaxed/simple;
	bh=1QG3SVpu58zAKVQ0hH5HKMHRFBBYiIR4Gyictzlvj38=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpYxOhC5Cai/aM5dzi387QSXe4t98pYaKfbP5DBKafRzznCbVGBqp522wdyoLBQfBTru5s3jpTxO0QPmkfGZnTWz1MEhxGOD4hrkQ9qIiIBHviSGwPChYnL4asGk5zahGYgeE/+qevh44+a6pDhmIqxNDHavuHak+3OYbhzfgns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2LgiXNfZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2LgiXNfZ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-724f42c1c38so3388958b3a.1
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683255; x=1733288055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7m4PnThamll/bllhIx+eaN/eVvtz00xLHe4m6xNTpg=;
        b=2LgiXNfZ0Szh+yn1zJX0pWOmZDr67ZgkyNMs1yx65R+s534+i4KuRBMGm1wxJislmw
         JO3/2DJeaX5fwCaMe1lrh3kIzBQ9rzsVSsAQvysO0seM71IiNVXDkoFwymKKfFHpE+5Y
         QdmpcSg1yhEd/WGzp9d7VRH1RcnrpQx03giOeYG25RPUdbAZmWYikts1t74xCq4BSWyW
         zs3X9OknIvuhSzkWipnRo0g7xeiyTFhjeCQuNdhF/tN37gAjWrpUV09eltaq5lRjiGpr
         n/G5KysfCeQ2ReAG4hOXZZkU2XGzUjs4YSC6VDxL8bwL30PZnhruBwyBkENTRUBXv7ve
         4uCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683255; x=1733288055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7m4PnThamll/bllhIx+eaN/eVvtz00xLHe4m6xNTpg=;
        b=nG0PbwhpIZgFnBHO9UF7O/zXTEQf2/GdBnL38g+HT1JDi/Bu54ytC2r8VVQgNUQfLn
         PU1lqG1AR2mKoVrs8w9iq7rbGpK5m/ELCkNcIUM01ToMKPNt/3D8PgzM03RyetcJ9mV/
         ey2MOh2cebybwTPZWqOoKETP0aTkDYqTOjbDAgis4jEWoT/LJH/1YmeXfRooA4u7YDWK
         Y9KT+xyWu8Fd5DJ82gSuDmjqGnGf4zKvi9Tvhq7AfFkLPeB+oUApcAeSzXxw2SVCg3DV
         RQt4DL+3GBMSNy1Dr7/zBO/fyoNrcA4TQV1XuU/MDoq510LuMMXs1vwPdMJhbf0qszC0
         NoHQ==
X-Gm-Message-State: AOJu0Ywpk12eFWMysEOkLHCY9PVnyo01NylufHiPSik/ynMhRMWaKVmS
	M4supMpHx6ExmvlJQsXAgRBaK+VAEEOF1aVwaklXtG43XBdXqALWTgNf/qKBbGfYf4cadvH4V/M
	Z
X-Gm-Gg: ASbGncu7+yQalB+ph6L70KzgZwVtqMKKbqw1sfCKwnqKkBdOuvtDSmVXvhrhr/oY2+B
	78kk++uHM2V1KFQmwY4JMiqK9bu12wd7zE58tae2Zlbo+lLUmFKxJBScF82SWUHnmxGYZdmqw7y
	oaXwI6Vy+Vkk1oAo5eqTI9LZueqpze2yccaeTyXGTqFnit8SAXx7ewp1RmT0yu0WIBMCvVieJje
	/3kEu2EZlVVMdT2XgMriGzp1+seWbks5c9ybDJF5FmOs5REHHOQRTv36cUFK9Xg5uLWLRxI0S+4
	XboNtyJPM+wykCCU8iMfuL0R
X-Google-Smtp-Source: AGHT+IG+/woLtbJI77y0BJ75S0owj0W0yzVc/Ag3JNbN4sX3vYHEaaln9sqhtHbBADGhvrWnoBkBJg==
X-Received: by 2002:a05:6a21:99a5:b0:1e0:df27:10b8 with SMTP id adf61e73a8af0-1e0e0b52839mr3347220637.31.1732683253842;
        Tue, 26 Nov 2024 20:54:13 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de48f13fsm9351365b3a.84.2024.11.26.20.54.07
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:54:10 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZUX-0Sde
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQeJ-0vc7
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 11/40] fstests: use syncfs rather than sync
Date: Wed, 27 Nov 2024 15:51:41 +1100
Message-ID: <20241127045403.3665299-12-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127045403.3665299-1-david@fromorbit.com>
References: <20241127045403.3665299-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

sync(1) is a system wide sync and is implemented by iterating all
the superblocks in the system. In most cases, fstests require just
the filesystem under test to be synced - we require syncfs(2)
semantics but what we use is sync(2) semantics.

The result of this is that when running many concurrent fstests at
the same time, we can have *hundreds* of concurrent sync operations
in progress (thanks fsstress!) and this causes excessive
interference with other tests that are running on other filesystems.

For example, some tests try to specifically control extent layout
via specific write and fsync patterns. All these global syncs
perturb them and cause them to spuriously fail.

A random snapshot of running concurrent tests shows just how many
tests are explicitly blocked in sync(1):

check-parallel───check───077───077─┬─cut
      │                                    ├─du
      │                                    └─tail
      ├─check-parallel───check───311───xfs_scrub───{xfs_scrub}
      ├─check-parallel───check───531───128*[t_open_tmpfiles]
      ├─check-parallel───check───227
      ├─check-parallel───check───388
      ├─check-parallel───check───070───fsstress───fsstress───{fsstress+
      ├─check-parallel───check───232───fsstress───7*[fsstress───{fsstr+
      ├─check-parallel───check───648───sleep
      ├─check-parallel───check───409───sync
      ├─check-parallel───check───683───sync
      ├─check-parallel───check───013─┬─013───sleep
      │                              └─fsstress───2*[fsstress───{fsstr+
      ├─check-parallel───check───684───sync
      ├─check-parallel───check───673───sync
      ├─check-parallel───check───118───dd
      ├─check-parallel───check───467───open_by_handle
      ├─check-parallel───check─┬─622
      │                        └─check
      ├─check-parallel───check───685───sync
      ├─check-parallel───check───049───fsstress───fsstress───{fsstress+
      ├─check-parallel───check───599
      ├─check-parallel───check───426───open_by_handle
      ├─check-parallel───check───057───umount
      ├─check-parallel───check───390───fsstress─┬─18*[fsstress───{fsst+
      │                                         └─fsstress
      ├─check-parallel───check───158───fsstress───fsstress───{fsstress+
      ├─check-parallel───check───017
      ├─check-parallel───check───032───fsstress───fsstress
      ├─check-parallel───check───076
      ├─check-parallel───check───477───open_by_handle
      ├─check-parallel───check───170───2*[170───170]
      ├─check-parallel───check───112
      ├─check-parallel───check───686───sync
      ├─4*[check-parallel───check───check───xfs_scrub───{xfs_scrub}]
      ├─check-parallel───check───387───xfs_io───{xfs_io}
      ├─check-parallel───check───615───615
      ├─check-parallel───check─┬─051
      │                        └─check───xfs_repair
      ├─check-parallel───check───049
      ├─check-parallel───check───247
      ├─check-parallel───check───674───sync
      ├─check-parallel───check───040
      ├─check-parallel───check───560───fsstress───fsstress───{fsstress+
      ├─check-parallel───check───030─┬─030─┬─030───xfs_repair
      │                              │     └─030───perl
      │                              ├─sed
      │                              └─uniq
      ├─check-parallel───check───055───055
      ├─2*[check-parallel───check───check]
      ├─check-parallel───check───042
      ├─check-parallel───check───204
      ├─check-parallel───check───271─┬─271───sed
      │                              └─md5sum
      ├─check-parallel───check───091─┬─fsx
      │                              └─tee
      ├─check-parallel───check───063───sleep
      ├─check-parallel───check───026
      ├─check-parallel───check───459───lvm
      ├─check-parallel───check───495
      ├─check-parallel───check───141───fsstress───4*[fsstress]
      ├─check-parallel───check───011─┬─fsstress─┬─fsstress───{fsstress+
      │                              │          └─fsstress
      │                              └─sleep
      ├─check-parallel───check───328───sync
      ├─check-parallel───check───507───507
      ├─check-parallel───check
      ├─check-parallel───check───687───sync
      ├─check-parallel───check───109───mkfs.xfs
      ├─check-parallel───check───324
      ├─check-parallel───check───114───aio-dio-eof-rac
      └─check-parallel───check───503───xfs_scrub───2*[{xfs_scrub}]

There are ~10 sync(1) calls blocked and at least half of the 50-odd
fsstress processes currently running are also going to be stuck in
sync(2) calls.

They are stuck because the superblock iteration has to wait for
mount, unmount, freeze, thaw and any other operation that locks a
superblock exclusively. When running dozens of tests concurrently,
there can be tens of superblocks that are locked exclusively for
every second for significant lengths of time.

Hence the use of sync has impact on both performance and test
behaviour and we need to minimise the amount of sync(1) and
sync(2) usage as much as possible.

Introduce _test_sync() and _scratch_sync() so we can implement
a syncfs mechanism with a fallback to sync(1) if it is not supported
without dirtying all the test code unnecessarily. Then convert
fsstress to use syncfs(2) in preference to sync(2).

This commit changes all the generic and XFS tests to use the new
sync functions, other filesystem specific tests will eventually
need to be converted to avoid similar problems.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/encrypt    |  2 +-
 common/log        |  2 +-
 common/quota      |  2 +-
 common/rc         | 24 ++++++++++++++++++++++++
 common/repair     |  2 +-
 common/report     |  2 +-
 common/verity     |  2 +-
 common/xfs        |  2 +-
 ltp/fsstress.c    | 12 ++++++++++++
 tests/generic/015 |  2 +-
 tests/generic/029 |  2 +-
 tests/generic/030 |  2 +-
 tests/generic/032 |  2 +-
 tests/generic/034 |  2 +-
 tests/generic/039 |  2 +-
 tests/generic/040 |  2 +-
 tests/generic/041 |  2 +-
 tests/generic/048 |  2 +-
 tests/generic/049 |  2 +-
 tests/generic/051 |  4 ++--
 tests/generic/054 |  2 +-
 tests/generic/057 |  2 +-
 tests/generic/059 |  2 +-
 tests/generic/065 |  2 +-
 tests/generic/066 |  2 +-
 tests/generic/073 |  2 +-
 tests/generic/090 |  4 ++--
 tests/generic/092 |  2 +-
 tests/generic/098 |  4 ++--
 tests/generic/101 |  2 +-
 tests/generic/104 |  2 +-
 tests/generic/106 |  2 +-
 tests/generic/107 |  2 +-
 tests/generic/150 |  2 +-
 tests/generic/151 |  2 +-
 tests/generic/152 |  2 +-
 tests/generic/157 |  3 ++-
 tests/generic/158 |  3 ++-
 tests/generic/159 |  2 +-
 tests/generic/160 |  2 +-
 tests/generic/171 |  4 ++--
 tests/generic/172 |  4 ++--
 tests/generic/173 |  4 ++--
 tests/generic/174 |  4 ++--
 tests/generic/204 |  8 --------
 tests/generic/247 |  2 +-
 tests/generic/250 |  2 +-
 tests/generic/252 |  2 +-
 tests/generic/265 |  2 +-
 tests/generic/266 |  2 +-
 tests/generic/267 |  2 +-
 tests/generic/268 |  2 +-
 tests/generic/271 |  2 +-
 tests/generic/272 |  2 +-
 tests/generic/273 |  2 +-
 tests/generic/274 |  6 +++---
 tests/generic/275 |  6 +++---
 tests/generic/276 |  2 +-
 tests/generic/278 |  2 +-
 tests/generic/279 |  2 +-
 tests/generic/281 |  2 +-
 tests/generic/282 |  2 +-
 tests/generic/283 |  2 +-
 tests/generic/315 |  2 +-
 tests/generic/317 |  2 +-
 tests/generic/318 |  2 +-
 tests/generic/325 |  2 +-
 tests/generic/328 |  4 ++--
 tests/generic/329 |  2 +-
 tests/generic/330 |  2 +-
 tests/generic/331 |  2 +-
 tests/generic/332 |  2 +-
 tests/generic/335 |  2 +-
 tests/generic/336 |  2 +-
 tests/generic/341 |  2 +-
 tests/generic/342 |  2 +-
 tests/generic/343 |  2 +-
 tests/generic/347 |  2 +-
 tests/generic/348 |  2 +-
 tests/generic/353 |  2 +-
 tests/generic/376 |  2 +-
 tests/generic/382 |  2 +-
 tests/generic/387 |  2 +-
 tests/generic/391 |  2 +-
 tests/generic/409 |  2 +-
 tests/generic/410 |  2 +-
 tests/generic/411 |  2 +-
 tests/generic/416 |  2 +-
 tests/generic/422 |  4 ++--
 tests/generic/425 |  2 +-
 tests/generic/461 |  2 +-
 tests/generic/474 |  4 ++--
 tests/generic/479 |  2 +-
 tests/generic/480 |  2 +-
 tests/generic/483 |  2 +-
 tests/generic/489 |  2 +-
 tests/generic/502 |  2 +-
 tests/generic/505 |  2 +-
 tests/generic/506 |  2 +-
 tests/generic/507 |  2 +-
 tests/generic/508 |  2 +-
 tests/generic/510 |  2 +-
 tests/generic/520 |  2 +-
 tests/generic/526 |  2 +-
 tests/generic/527 |  2 +-
 tests/generic/535 |  2 +-
 tests/generic/546 |  2 +-
 tests/generic/556 |  2 +-
 tests/generic/579 |  2 +-
 tests/generic/589 |  2 +-
 tests/generic/599 |  2 +-
 tests/generic/610 |  2 +-
 tests/generic/628 |  4 ++--
 tests/generic/629 |  4 ++--
 tests/generic/640 |  2 +-
 tests/generic/673 |  2 +-
 tests/generic/674 |  2 +-
 tests/generic/675 |  2 +-
 tests/generic/677 |  2 +-
 tests/generic/683 |  2 +-
 tests/generic/684 |  2 +-
 tests/generic/685 |  2 +-
 tests/generic/686 |  2 +-
 tests/generic/687 |  2 +-
 tests/generic/688 |  2 +-
 tests/generic/690 |  2 +-
 tests/generic/694 |  2 +-
 tests/generic/695 |  2 +-
 tests/generic/703 |  2 +-
 tests/generic/716 |  2 +-
 tests/generic/718 |  2 +-
 tests/generic/719 |  2 +-
 tests/generic/721 |  2 +-
 tests/generic/725 |  2 +-
 tests/generic/726 |  2 +-
 tests/generic/727 |  2 +-
 tests/generic/735 |  2 +-
 tests/generic/738 |  2 +-
 tests/generic/745 |  4 ++--
 tests/generic/746 |  4 ++--
 tests/generic/747 |  4 ++--
 tests/generic/749 |  4 ++--
 tests/xfs/016     |  4 ++--
 tests/xfs/052     |  2 +-
 tests/xfs/110     |  2 +-
 tests/xfs/118     |  4 ++--
 tests/xfs/119     |  2 +-
 tests/xfs/128     |  2 +-
 tests/xfs/133     |  2 +-
 tests/xfs/134     |  2 +-
 tests/xfs/161     |  2 +-
 tests/xfs/176     |  2 +-
 tests/xfs/195     |  2 +-
 tests/xfs/201     |  4 ++--
 tests/xfs/212     |  2 +-
 tests/xfs/227     |  2 +-
 tests/xfs/231     |  4 ++--
 tests/xfs/232     |  4 ++--
 tests/xfs/234     |  2 +-
 tests/xfs/236     |  2 +-
 tests/xfs/237     |  2 +-
 tests/xfs/239     |  2 +-
 tests/xfs/240     |  2 +-
 tests/xfs/241     |  2 +-
 tests/xfs/243     |  4 ++--
 tests/xfs/246     |  2 +-
 tests/xfs/265     |  2 +-
 tests/xfs/272     |  2 +-
 tests/xfs/274     |  2 +-
 tests/xfs/276     |  2 +-
 tests/xfs/291     |  4 ++--
 tests/xfs/309     |  2 +-
 tests/xfs/312     |  2 +-
 tests/xfs/313     |  2 +-
 tests/xfs/314     |  2 +-
 tests/xfs/315     |  4 ++--
 tests/xfs/316     |  2 +-
 tests/xfs/317     |  2 +-
 tests/xfs/318     |  4 ++--
 tests/xfs/319     |  2 +-
 tests/xfs/320     |  2 +-
 tests/xfs/321     |  2 +-
 tests/xfs/322     |  2 +-
 tests/xfs/323     |  2 +-
 tests/xfs/324     |  2 +-
 tests/xfs/325     |  4 ++--
 tests/xfs/326     |  4 ++--
 tests/xfs/327     |  2 +-
 tests/xfs/420     |  2 +-
 tests/xfs/421     |  2 +-
 tests/xfs/423     |  2 +-
 tests/xfs/438     |  2 +-
 tests/xfs/440     |  2 +-
 tests/xfs/442     |  2 +-
 tests/xfs/511     |  2 +-
 tests/xfs/519     |  2 +-
 tests/xfs/520     |  2 +-
 tests/xfs/541     |  2 +-
 tests/xfs/553     |  4 ++--
 tests/xfs/558     |  6 +++---
 tests/xfs/607     |  6 +++---
 tests/xfs/617     |  2 +-
 tests/xfs/629     |  2 +-
 tests/xfs/630     |  2 +-
 tests/xfs/631     |  2 +-
 tests/xfs/790     |  2 +-
 tests/xfs/791     |  2 +-
 tests/xfs/792     |  2 +-
 208 files changed, 279 insertions(+), 249 deletions(-)

diff --git a/common/encrypt b/common/encrypt
index d90a566ac..52f23cd0a 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -686,7 +686,7 @@ _get_ciphertext_block_list()
 {
 	local file=$1
 
-	sync
+	_sync_fs $file
 	$XFS_IO_PROG -c fiemap $file | perl -ne '
 		next if not /^\s*\d+: \[\d+\.\.\d+\]: (\d+)\.\.(\d+)/;
 		print $_ . "," foreach $1..$2;' | sed 's/,$//'
diff --git a/common/log b/common/log
index ea7e4158e..ab7bc9f87 100644
--- a/common/log
+++ b/common/log
@@ -392,7 +392,7 @@ _create_log_sync()
     # add some syncs to get the log flushed to disk 
     for file in $SCRATCH_MNT/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}; do
 	touch $file
-	sync
+	_scratch_sync
     done
 
     # unmount the FS
diff --git a/common/quota b/common/quota
index 3bf7d552e..e87489192 100644
--- a/common/quota
+++ b/common/quota
@@ -336,7 +336,7 @@ _qmount_option()
 _check_quota_usage()
 {
 	# Sync to get delalloc to disk
-	sync
+	_scratch_sync
 
 	# kill caches to guarantee removal speculative delalloc
 	# XXX: really need an ioctl instead of this big hammer
diff --git a/common/rc b/common/rc
index a601e2c80..6f939e3b5 100644
--- a/common/rc
+++ b/common/rc
@@ -6,6 +6,30 @@
 
 BC="$(type -P bc)" || BC=
 
+# Don't use sync(1) directly if at all possible. In most cases we only need to
+# sync the fs under test, so we use syncfs if it is supported to prevent
+# disturbance of other tests that may be running concurrently.
+_sync_fs()
+{
+	local dir=$1
+
+	if [ -e $dir ]; then
+		$XFS_IO_PROG -rxc "syncfs" $dir > /dev/null 2>&1
+		return
+	fi
+	sync
+}
+
+_scratch_sync()
+{
+	_sync_fs $SCRATCH_MNT
+}
+
+_test_sync()
+{
+	_sync_fs $TEST_DIR
+}
+
 # Common execution handling for fsstress invocation.
 #
 # We need per-test fsstress binaries because of the way fsstress forks and
diff --git a/common/repair b/common/repair
index 8945d0028..0dae83052 100644
--- a/common/repair
+++ b/common/repair
@@ -119,7 +119,7 @@ _check_repair()
 	_scratch_mount
 	POSIXLY_CORRECT=yes \
 	dd if=/bin/bash of=$SCRATCH_MNT/sh 2>&1 |_filter_dd
-	sync
+	_scratch_sync
 	rm -f $SCRATCH_MNT/sh
 	_scratch_unmount
 
diff --git a/common/report b/common/report
index 0e91e481f..7128bbeba 100644
--- a/common/report
+++ b/common/report
@@ -156,7 +156,7 @@ ENDL
 		cat $report >> "$tmp_fn"
 	fi
 	echo "</testsuite>" >> "$tmp_fn"
-	sync "$tmp_fn" && mv "$tmp_fn" "$out_fn"
+	_sync_fs "$tmp_fn" && mv "$tmp_fn" "$out_fn"
 	echo "Xunit report: $out_fn"
 }
 
diff --git a/common/verity b/common/verity
index 59b67e120..11e839d2e 100644
--- a/common/verity
+++ b/common/verity
@@ -335,7 +335,7 @@ _fsv_scratch_corrupt_bytes()
 	local dd_cmds=()
 	local cmd
 
-	sync	# Sync to avoid unwritten extents
+	_scratch_sync	# Sync to avoid unwritten extents
 
 	cat > $tmp.bytes
 	local end=$(( offset + $(_get_filesize $tmp.bytes ) ))
diff --git a/common/xfs b/common/xfs
index 68abfa71d..0417a40ad 100644
--- a/common/xfs
+++ b/common/xfs
@@ -1087,7 +1087,7 @@ _scratch_xfs_unmount_dirty()
 
 	rm -f "$f"
 	echo "test" > "$f"
-	sync
+	_scratch_sync
 	_scratch_shutdown
 	_scratch_unmount
 }
diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index a6840f28c..8b8c9035f 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -5241,6 +5241,18 @@ symlink_f(opnum_t opno, long r)
 void
 sync_f(opnum_t opno, long r)
 {
+	int	fd;
+
+	fd = open(homedir, O_RDONLY|O_DIRECTORY);
+	if (fd < 0)
+		goto use_sync;
+	syncfs(fd);
+	close(fd);
+	if (verbose)
+		printf("%d/%lld: syncfs\n", procid, opno);
+	return;
+
+use_sync:
 	sync();
 	if (verbose)
 		printf("%d/%lld: sync\n", procid, opno);
diff --git a/tests/generic/015 b/tests/generic/015
index d4f81c7f6..3cbb2f2d0 100755
--- a/tests/generic/015
+++ b/tests/generic/015
@@ -85,7 +85,7 @@ fi
 
 echo "check free space:"
 
-sync
+_scratch_sync
 
 free2=`_free`
 if [ -z "$free2" ]
diff --git a/tests/generic/029 b/tests/generic/029
index 0af46e892..c6162b0b4 100755
--- a/tests/generic/029
+++ b/tests/generic/029
@@ -43,7 +43,7 @@ echo "==== Post-Remount =="
 _hexdump $testfile
 
 rm -f $testfile
-sync
+_scratch_sync
 
 # second case is to do a mwrite between the truncate to a block on the
 # same page we are truncating within the EOF. This checks that a mapped
diff --git a/tests/generic/030 b/tests/generic/030
index 3f0e5b993..b1b51469c 100755
--- a/tests/generic/030
+++ b/tests/generic/030
@@ -48,7 +48,7 @@ echo "==== Post-Remount =="
 _hexdump $testfile
 
 rm -f $testfile
-sync
+_scratch_sync
 
 # second case is to do a mwrite between the truncate to a block on the
 # same page we are truncating within the EOF. This checks that a mapped
diff --git a/tests/generic/032 b/tests/generic/032
index 63abd62a8..30290c722 100755
--- a/tests/generic/032
+++ b/tests/generic/032
@@ -29,7 +29,7 @@ _cleanup()
 _syncloop()
 {
 	while [ true ]; do
-		sync
+		_scratch_sync
 	done
 }
 
diff --git a/tests/generic/034 b/tests/generic/034
index 71aae2a01..cd22f330d 100755
--- a/tests/generic/034
+++ b/tests/generic/034
@@ -41,7 +41,7 @@ touch $SCRATCH_MNT/test_dir/foo
 # The intention is that at log recovery time we have a dir entry for 'foo' both
 # in the fs/subvol tree and in the log tree - this is necessary to trigger the
 # bug on btrfs.
-sync
+_scratch_sync
 
 touch $SCRATCH_MNT/test_dir/bar
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/test_dir
diff --git a/tests/generic/039 b/tests/generic/039
index 5162e85b0..00d4e4afb 100755
--- a/tests/generic/039
+++ b/tests/generic/039
@@ -44,7 +44,7 @@ echo "hello world" > $SCRATCH_MNT/a/b/foo
 ln $SCRATCH_MNT/a/b/foo $SCRATCH_MNT/a/b/bar
 
 # Make sure all metadata and data are durably persisted.
-sync
+_scratch_sync
 
 # Now remove one of the hard links and fsync the inode.
 rm -f $SCRATCH_MNT/a/b/bar
diff --git a/tests/generic/040 b/tests/generic/040
index eb88e9eed..8b4e3b703 100755
--- a/tests/generic/040
+++ b/tests/generic/040
@@ -60,7 +60,7 @@ for i in `seq 1 3000`; do
 done
 
 # Make sure all metadata and data are durably persisted.
-sync
+_scratch_sync
 
 # Add one more link to the inode that ends up being a btrfs extref and fsync
 # the inode.
diff --git a/tests/generic/041 b/tests/generic/041
index 447013689..6d42d1a28 100755
--- a/tests/generic/041
+++ b/tests/generic/041
@@ -64,7 +64,7 @@ for i in `seq 1 3000`; do
 done
 
 # Make sure all metadata and data are durably persisted.
-sync
+_scratch_sync
 
 # Now remove one link, add a new one with a new name, add another new one with
 # the same name as the one we just removed and fsync the inode.
diff --git a/tests/generic/048 b/tests/generic/048
index 7b28cb053..5c554d501 100755
--- a/tests/generic/048
+++ b/tests/generic/048
@@ -69,7 +69,7 @@ do
 done
 
 # sync, then shutdown immediately after, then remount and test
-sync
+_scratch_sync
 _scratch_shutdown
 _scratch_unmount
 _scratch_mount
diff --git a/tests/generic/049 b/tests/generic/049
index 8e4b99565..94b5afe96 100755
--- a/tests/generic/049
+++ b/tests/generic/049
@@ -66,7 +66,7 @@ do
 done
 
 # sync, then shutdown immediately after, then remount and test
-sync
+_scratch_sync
 _scratch_shutdown
 _scratch_unmount
 _scratch_mount
diff --git a/tests/generic/051 b/tests/generic/051
index 69250cde6..5ee4dfdba 100755
--- a/tests/generic/051
+++ b/tests/generic/051
@@ -30,7 +30,7 @@ load_dir=$SCRATCH_MNT/test
 _run_fsstress_bg -n 10000000 -p $PROCS -d $load_dir
 sleep $SLEEP_TIME
 _kill_fsstress
-sync
+_scratch_sync
 _scratch_unmount
 
 # now mount again, run the load again, this time with a shutdown.
@@ -38,7 +38,7 @@ _scratch_mount
 $XFS_FSR_PROG -v $load_dir >> $seqres.full 2>&1
 _run_fsstress_bg -n10000000 -p $PROCS -d $load_dir
 sleep $SLEEP_TIME
-sync
+_scratch_sync
 
 # now shutdown and unmount
 sleep 5
diff --git a/tests/generic/054 b/tests/generic/054
index 20e9a1e96..0649b2593 100755
--- a/tests/generic/054
+++ b/tests/generic/054
@@ -67,7 +67,7 @@ for s in sync nosync ; do
 	    # add some syncs to get the log flushed to disk
 	    for file in $SCRATCH_MNT/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}; do
 		touch $file
-		sync
+		_scratch_sync
 	    done
 	else
 	    # generate some log traffic - but not too much - life gets a little
diff --git a/tests/generic/057 b/tests/generic/057
index c92af5ddb..c5db80977 100755
--- a/tests/generic/057
+++ b/tests/generic/057
@@ -41,7 +41,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0xaa -b 8K 0 8K" \
 	$SCRATCH_MNT/foo | _filter_xfs_io
 
 # Make sure the file is durably persisted.
-sync
+_scratch_sync
 
 # Append some data to our file, to increase its size.
 $XFS_IO_PROG -f -c "pwrite -S 0xcc -b 4K 8K 4K" \
diff --git a/tests/generic/059 b/tests/generic/059
index 0d3270787..db48de378 100755
--- a/tests/generic/059
+++ b/tests/generic/059
@@ -58,7 +58,7 @@ $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
 # that modifies the data or metadata of our file, should update those fields in
 # the btrfs inode with values that make the next fsync operation write to the
 # fsync log.
-sync
+_scratch_sync
 
 # Sleep for 1 second, because we want to check that the next punch operations we
 # do update the file's mtime and ctime.
diff --git a/tests/generic/065 b/tests/generic/065
index adf55b750..f7e1e276f 100755
--- a/tests/generic/065
+++ b/tests/generic/065
@@ -42,7 +42,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0xaa 0 8K" $SCRATCH_MNT/foo | _filter_xfs_io
 mkdir $SCRATCH_MNT/mydir
 
 # Make sure all metadata and data are durably persisted.
-sync
+_scratch_sync
 
 # Add a hard link to 'foo' inside our test directory and fsync only the
 # directory. The btrfs fsync implementation had a bug that caused the new
diff --git a/tests/generic/066 b/tests/generic/066
index e32e9658b..37d04e069 100755
--- a/tests/generic/066
+++ b/tests/generic/066
@@ -48,7 +48,7 @@ $SETFATTR_PROG -n user.attr2 -v val2 $SCRATCH_MNT/foobar
 $SETFATTR_PROG -n user.attr3 -v val3 $SCRATCH_MNT/foobar
 
 # Make sure everything is durably persisted.
-sync
+_scratch_sync
 
 # Now delete the second xattr and fsync the inode.
 $SETFATTR_PROG -x user.attr2 $SCRATCH_MNT/foobar
diff --git a/tests/generic/073 b/tests/generic/073
index 5ebf634fa..05df1ea87 100755
--- a/tests/generic/073
+++ b/tests/generic/073
@@ -51,7 +51,7 @@ touch $SCRATCH_MNT/testdir_1/bar
 mkdir $SCRATCH_MNT/testdir_2
 
 # Make sure everything is durably persisted.
-sync
+_scratch_sync
 
 # Write more 8Kb of data to our file.
 $XFS_IO_PROG -c "pwrite -S 0xbb 8K 8K" $SCRATCH_MNT/foo | _filter_xfs_io
diff --git a/tests/generic/090 b/tests/generic/090
index 36a9ee865..b1ea27bbd 100755
--- a/tests/generic/090
+++ b/tests/generic/090
@@ -41,7 +41,7 @@ _mount_flakey
 $XFS_IO_PROG -f -c "pwrite -S 0xaa 0 32k" \
 		-c "fsync" \
 		$SCRATCH_MNT/foo | _filter_xfs_io
-sync
+_scratch_sync
 
 # Add a hard link to our file.
 # On btrfs this sets the flag BTRFS_INODE_COPY_EVERYTHING on the btrfs inode,
@@ -50,7 +50,7 @@ ln $SCRATCH_MNT/foo $SCRATCH_MNT/bar
 
 # Sync the filesystem to force a commit of the current btrfs transaction, this
 # is a necessary condition to trigger the bug on btrfs.
-sync
+_scratch_sync
 
 # Now append more data to our file, increasing its size, and fsync the file.
 # In btrfs because the inode flag BTRFS_INODE_COPY_EVERYTHING was set and the
diff --git a/tests/generic/092 b/tests/generic/092
index d8c223270..3a61f00f7 100755
--- a/tests/generic/092
+++ b/tests/generic/092
@@ -36,7 +36,7 @@ _require_congruent_file_oplen $TEST_DIR $((7 * 1048576))
 # past i_size
 $XFS_IO_PROG -f -c "falloc -k 0 10M" -c "pwrite 0 5M" -c "truncate 5M"\
 	$TEST_DIR/testfile.$seq | _filter_xfs_io
-sync
+_test_sync
 $XFS_IO_PROG -c "fiemap -v" $TEST_DIR/testfile.$seq | _filter_fiemap
 
 # Now verify that if we truncate up past i_size we don't trim the preallocated
diff --git a/tests/generic/098 b/tests/generic/098
index 57de42e9c..ff6cf908e 100755
--- a/tests/generic/098
+++ b/tests/generic/098
@@ -38,7 +38,7 @@ workout()
 
 	# Create our test file with some data and durably persist it.
 	$XFS_IO_PROG -t -f -c "pwrite -S 0xaa 0 128K" $SCRATCH_MNT/foo | _filter_xfs_io
-	sync
+	_scratch_sync
 
 	# Append some data to the file, increasing its size, and leave a hole between
 	# the old size and the start offset if the following write. So our file gets
@@ -49,7 +49,7 @@ workout()
 	# This is required to trigger a bug in btrfs truncate where it updates on-disk
 	# inode size incorrectly.
 	if [ $need_sync -eq 1 ]; then
-		sync
+		_scratch_sync
 	fi
 
 	# Now truncate our file to a smaller size that is in the middle of the hole we
diff --git a/tests/generic/101 b/tests/generic/101
index 2e9543579..4295f0801 100755
--- a/tests/generic/101
+++ b/tests/generic/101
@@ -49,7 +49,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0xaa 0 64K"         \
 $XFS_IO_PROG -f -c "pwrite -S 0xee 0 64K"         \
 		-c "pwrite -S 0xff 64K 61K"       \
 		$SCRATCH_MNT/bar | _filter_xfs_io
-sync
+_scratch_sync
 
 # Now truncate our file foo to a smaller size (64Kb) and then truncate it to the
 # size it had before the shrinking truncate (125Kb). Then fsync our file. If a
diff --git a/tests/generic/104 b/tests/generic/104
index 7f294e1b6..9af3b5582 100755
--- a/tests/generic/104
+++ b/tests/generic/104
@@ -38,7 +38,7 @@ touch $SCRATCH_MNT/testdir/foo
 touch $SCRATCH_MNT/testdir/bar
 
 # Make sure everything done so far is durably persisted.
-sync
+_scratch_sync
 
 # Create one hard link for file foo and another one for file bar. After that
 # fsync only the file bar.
diff --git a/tests/generic/106 b/tests/generic/106
index 2b89ae69a..8bcc7575e 100755
--- a/tests/generic/106
+++ b/tests/generic/106
@@ -37,7 +37,7 @@ touch $SCRATCH_MNT/testdir/foo
 ln $SCRATCH_MNT/testdir/foo $SCRATCH_MNT/testdir/bar
 
 # Make sure everything done so far is durably persisted.
-sync
+_scratch_sync
 
 # Now remove one of the links, trigger inode eviction and then fsync our
 # inode.
diff --git a/tests/generic/107 b/tests/generic/107
index 177ca59c5..8a82d1468 100755
--- a/tests/generic/107
+++ b/tests/generic/107
@@ -41,7 +41,7 @@ ln $SCRATCH_MNT/foo $SCRATCH_MNT/testdir/foo2
 ln $SCRATCH_MNT/foo $SCRATCH_MNT/testdir/foo3
 
 # Make sure everything done so far is durably persisted.
-sync
+_scratch_sync
 
 # Now we remove one of our file's hardlinks in the directory testdir.
 unlink $SCRATCH_MNT/testdir/foo3
diff --git a/tests/generic/150 b/tests/generic/150
index 159a53c4d..d9a53a5b1 100755
--- a/tests/generic/150
+++ b/tests/generic/150
@@ -38,7 +38,7 @@ sz=$((blksz * blks))
 nr=7
 filesize=$((blksz * nr))
 _pwrite_byte 0x61 0 $sz $testdir/file1 >> $seqres.full
-sync
+_test_sync
 free_blocks0=$(stat -f $testdir -c '%f')
 
 echo "Create the reflink copies"
diff --git a/tests/generic/151 b/tests/generic/151
index a335b9273..d20477ab3 100755
--- a/tests/generic/151
+++ b/tests/generic/151
@@ -43,7 +43,7 @@ free_blocks0=$(stat -f $testdir -c '%f')
 nr=7
 filesize=$((blksz * nr))
 _pwrite_byte 0x61 0 $sz $testdir/file1 >> $seqres.full
-sync
+_test_sync
 
 echo "Create the reflink copies"
 for i in `seq 2 $nr`; do
diff --git a/tests/generic/152 b/tests/generic/152
index 8d87dbac7..afcbd6d93 100755
--- a/tests/generic/152
+++ b/tests/generic/152
@@ -44,7 +44,7 @@ free_blocks0=$(stat -f $testdir -c '%f')
 nr=4
 filesize=$((blksz * nr))
 _pwrite_byte 0x61 0 $sz $testdir/file1 >> $seqres.full
-sync
+_test_sync
 
 echo "Create the reflink copies"
 for i in `seq 2 $nr`; do
diff --git a/tests/generic/157 b/tests/generic/157
index cb9143673..24415937c 100755
--- a/tests/generic/157
+++ b/tests/generic/157
@@ -54,7 +54,8 @@ seq 1 $((2 * blksz / 250)) | while read f; do
 done
 mknod $testdir1/dev1 c 1 3
 mkfifo $testdir1/fifo1
-sync
+_test_sync
+_scratch_sync
 
 _filter_enotty() {
 	sed -e 's/Inappropriate ioctl for device/Invalid argument/g'
diff --git a/tests/generic/158 b/tests/generic/158
index 171d3c0dc..ccee3690a 100755
--- a/tests/generic/158
+++ b/tests/generic/158
@@ -55,7 +55,8 @@ seq 1 $((2 * blksz / 250)) | while read f; do
 done
 mknod $testdir1/dev1 c 1 3
 mkfifo $testdir1/fifo1
-sync
+_test_sync
+_scratch_sync
 
 _filter_enotty() {
 	_filter_dedupe_error | \
diff --git a/tests/generic/159 b/tests/generic/159
index c4dec17ca..a2d20622a 100755
--- a/tests/generic/159
+++ b/tests/generic/159
@@ -39,7 +39,7 @@ nr=4
 filesize=$((blksz * nr))
 _pwrite_byte 0x61 0 $sz $testdir1/file1 >> $seqres.full
 _pwrite_byte 0x61 0 $sz $testdir1/file2 >> $seqres.full
-sync
+_test_sync
 
 do_filter_output()
 {
diff --git a/tests/generic/160 b/tests/generic/160
index fc7a161e1..c1f24ddbb 100755
--- a/tests/generic/160
+++ b/tests/generic/160
@@ -39,7 +39,7 @@ nr=4
 filesize=$((blksz * nr))
 _pwrite_byte 0x61 0 $sz $testdir1/file1 >> $seqres.full
 _pwrite_byte 0x61 0 $sz $testdir1/file2 >> $seqres.full
-sync
+_test_sync
 
 do_filter_output()
 {
diff --git a/tests/generic/171 b/tests/generic/171
index dd56aa792..5c8504d26 100755
--- a/tests/generic/171
+++ b/tests/generic/171
@@ -49,12 +49,12 @@ mkdir $testdir
 echo "Create a big file and reflink it"
 _pwrite_byte 0x61 0 $((blksz * nr_blks)) $testdir/bigfile >> $seqres.full 2>&1
 _cp_reflink $testdir/bigfile $testdir/clonefile
-sync
+_scratch_sync
 
 echo "Allocate the rest of the space"
 nr_free=$(stat -f -c '%f' $testdir)
 _fill_fs $((nr_free * blksz)) $testdir/space $blksz 0 >> $seqres.full 2>&1
-sync
+_scratch_sync
 
 echo "CoW the big file"
 out="$(_pwrite_byte 0x62 0 $((blksz * nr_blks)) $testdir/bigfile 2>&1 | \
diff --git a/tests/generic/172 b/tests/generic/172
index c23a12284..17f817805 100755
--- a/tests/generic/172
+++ b/tests/generic/172
@@ -47,11 +47,11 @@ mkdir $testdir
 echo "Create a big file and reflink it"
 _pwrite_byte 0x61 0 $file_size $testdir/bigfile >> $seqres.full 2>&1
 _cp_reflink $testdir/bigfile $testdir/clonefile
-sync
+_scratch_sync
 
 echo "Allocate the rest of the space"
 _fill_fs $fs_size  $testdir/space $blksz 0 >> $seqres.full 2>&1
-sync
+_scratch_sync
 
 echo "CoW the big file"
 out="$(_pwrite_byte 0x62 0 $file_size $testdir/bigfile 2>&1 | \
diff --git a/tests/generic/173 b/tests/generic/173
index 8df3c6df2..d7ac7b15d 100755
--- a/tests/generic/173
+++ b/tests/generic/173
@@ -49,12 +49,12 @@ mkdir $testdir
 echo "Create a big file and reflink it"
 _pwrite_byte 0x61 0 $((blksz * nr_blks)) $testdir/bigfile >> $seqres.full 2>&1
 _cp_reflink $testdir/bigfile $testdir/clonefile
-sync
+_scratch_sync
 
 echo "Allocate the rest of the space"
 nr_free=$(stat -f -c '%f' $testdir)
 _fill_fs $((blksz * nr_free)) $testdir/space $blksz 0 >> $seqres.full 2>&1
-sync
+_scratch_sync
 
 echo "mmap CoW the big file"
 core_ulimit="$(ulimit -c)"
diff --git a/tests/generic/174 b/tests/generic/174
index b9c292071..c7c62001d 100755
--- a/tests/generic/174
+++ b/tests/generic/174
@@ -50,12 +50,12 @@ mkdir $testdir
 echo "Create a big file and reflink it"
 _pwrite_byte 0x61 0 $((blksz * nr_blks)) $testdir/bigfile >> $seqres.full 2>&1
 _cp_reflink $testdir/bigfile $testdir/clonefile
-sync
+_scratch_sync
 
 echo "Allocate the rest of the space"
 nr_free=$(stat -f -c '%f' $testdir)
 _fill_fs $((blksz * nr_free)) $testdir/space $blksz 0 >> $seqres.full 2>&1
-sync
+_scratch_sync
 
 echo "CoW the big file"
 out="$(_pwrite_byte 0x62 0 $((blksz * nr_blks)) $testdir/bigfile -d 2>&1 | \
diff --git a/tests/generic/204 b/tests/generic/204
index 9ef54e239..39483a09a 100755
--- a/tests/generic/204
+++ b/tests/generic/204
@@ -9,17 +9,9 @@
 . ./common/preamble
 _begin_fstest metadata rw auto
 
-# Override the default cleanup function.
-_cleanup()
-{
-	rm -f $tmp.*
-	sync
-}
-
 # Import common functions.
 . ./common/filter
 
-
 _require_scratch
 
 # For xfs, we need to handle the different default log sizes that different
diff --git a/tests/generic/247 b/tests/generic/247
index 47ff5c343..a758ae24c 100755
--- a/tests/generic/247
+++ b/tests/generic/247
@@ -39,7 +39,7 @@ iosize=1048576
 # Initialise file
 dd if=/dev/zero of=$testfile bs=$iosize count=$loops &> /dev/null
 [ $? -ne 0 ] && exit
-sync
+_test_sync
 	
 # Direct I/O overwriter
 dd if=/dev/zero of=$testfile oflag=direct bs=$iosize count=$loops conv=notrunc &> /dev/null &
diff --git a/tests/generic/250 b/tests/generic/250
index 196a34bb0..605d7c8ad 100755
--- a/tests/generic/250
+++ b/tests/generic/250
@@ -61,7 +61,7 @@ md5sum $testdir/file2 | _filter_scratch
 
 echo "Write and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
-sync
+_scratch_sync
 _dmerror_load_error_table
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $testdir/file2 \
 	>> $seqres.full 2>&1
diff --git a/tests/generic/252 b/tests/generic/252
index 3ee2b0a67..ddf950e34 100755
--- a/tests/generic/252
+++ b/tests/generic/252
@@ -64,7 +64,7 @@ md5sum $testdir/file2 | _filter_scratch
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
-sync
+_scratch_sync
 _dmerror_load_error_table
 $AIO_TEST -a $alignment -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
 _dmerror_load_working_table
diff --git a/tests/generic/265 b/tests/generic/265
index 3c84e2a84..0f165e7e6 100755
--- a/tests/generic/265
+++ b/tests/generic/265
@@ -53,7 +53,7 @@ md5sum $testdir/file1 | _filter_scratch
 md5sum $testdir/file2 | _filter_scratch
 
 echo "CoW and unmount"
-sync
+_scratch_sync
 _dmerror_load_error_table
 urk=$($XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" \
 	-c "fdatasync" $testdir/file2 2>&1)
diff --git a/tests/generic/266 b/tests/generic/266
index d5675afbc..02e290de5 100755
--- a/tests/generic/266
+++ b/tests/generic/266
@@ -53,7 +53,7 @@ md5sum $testdir/file1 | _filter_scratch
 md5sum $testdir/file2 | _filter_scratch
 
 echo "CoW and unmount"
-sync
+_scratch_sync
 _dmerror_load_error_table
 urk=$($XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" \
 	-c "fdatasync" $testdir/file2 2>&1)
diff --git a/tests/generic/267 b/tests/generic/267
index ddaf1064c..48b1981f1 100755
--- a/tests/generic/267
+++ b/tests/generic/267
@@ -53,7 +53,7 @@ md5sum $testdir/file1 | _filter_scratch
 md5sum $testdir/file2 | _filter_scratch
 
 echo "CoW and unmount"
-sync
+_scratch_sync
 _dmerror_load_error_table
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $testdir/file2 >> $seqres.full 2>&1
 _dmerror_load_working_table
diff --git a/tests/generic/268 b/tests/generic/268
index c6068cf4e..f46e0b755 100755
--- a/tests/generic/268
+++ b/tests/generic/268
@@ -54,7 +54,7 @@ md5sum $testdir/file1 | _filter_scratch
 md5sum $testdir/file2 | _filter_scratch
 
 echo "CoW and unmount"
-sync
+_scratch_sync
 _dmerror_load_error_table
 urk=$($XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" \
 	-c "fdatasync" $testdir/file2 2>&1)
diff --git a/tests/generic/271 b/tests/generic/271
index ce647d155..854ea1021 100755
--- a/tests/generic/271
+++ b/tests/generic/271
@@ -54,7 +54,7 @@ md5sum $testdir/file1 | _filter_scratch
 md5sum $testdir/file2 | _filter_scratch
 
 echo "CoW and unmount"
-sync
+_scratch_sync
 _dmerror_load_error_table
 urk=$($XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $testdir/file2 2>&1)
 echo $urk >> $seqres.full
diff --git a/tests/generic/272 b/tests/generic/272
index 3d2cace9f..bc77365df 100755
--- a/tests/generic/272
+++ b/tests/generic/272
@@ -54,7 +54,7 @@ md5sum $testdir/file1 | _filter_scratch
 md5sum $testdir/file2 | _filter_scratch
 
 echo "CoW and unmount"
-sync
+_scratch_sync
 _dmerror_load_error_table
 urk=$($XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $testdir/file2 2>&1)
 echo $urk >> $seqres.full
diff --git a/tests/generic/273 b/tests/generic/273
index e0ee0483a..5100e848b 100755
--- a/tests/generic/273
+++ b/tests/generic/273
@@ -92,7 +92,7 @@ _porter()
 		echo "_porter $_suffix not complete"
 	fi
 	
-	sync
+	_scratch_sync
 }
 
 _do_workload()
diff --git a/tests/generic/274 b/tests/generic/274
index d526a9b71..916c7173c 100755
--- a/tests/generic/274
+++ b/tests/generic/274
@@ -50,7 +50,7 @@ echo "Fill fs with 1M IOs; ENOSPC expected" >> $seqres.full
 dd if=/dev/zero of=$SCRATCH_MNT/tmp1 bs=1M >>$seqres.full 2>&1
 echo "Fill fs with 4K IOs; ENOSPC expected" >> $seqres.full
 dd if=/dev/zero of=$SCRATCH_MNT/tmp2 bs=4K >>$seqres.full 2>&1
-sync
+_scratch_sync
 # Last effort, use O_SYNC
 echo "Fill fs with 4K DIOs; ENOSPC expected" >> $seqres.full
 dd if=/dev/zero of=$SCRATCH_MNT/tmp3 bs=4K oflag=sync >>$seqres.full 2>&1
@@ -66,7 +66,7 @@ for i in `seq 1 2 1023`; do
 	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 conv=notrunc \
 		>>$seqres.full 2>/dev/null || _fail "failed to write to test file"
 done
-sync
+_scratch_sync
 echo >> $seqres.full
 echo "Fill in prealloc space; fill holes at offsets:" >> $seqres.full
 for i in `seq 2 2 1023`; do
@@ -74,7 +74,7 @@ for i in `seq 2 2 1023`; do
 	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 conv=notrunc \
 		>>$seqres.full 2>/dev/null || _fail "failed to fill test file"
 done
-sync
+_scratch_sync
 echo >> $seqres.full
 
 echo "done"
diff --git a/tests/generic/275 b/tests/generic/275
index 57de69b80..fbfe15816 100755
--- a/tests/generic/275
+++ b/tests/generic/275
@@ -51,9 +51,9 @@ dd if=/dev/zero of=$SCRATCH_MNT/tmp1 bs=256K count=1 >>$seqres.full 2>&1
 
 # Attempt to completely fill fs
 dd if=/dev/zero of=$SCRATCH_MNT/tmp2 bs=1M >>$seqres.full 2>&1
-sync
+_scratch_sync
 dd if=/dev/zero of=$SCRATCH_MNT/tmp3 bs=4K >>$seqres.full 2>&1
-sync
+_scratch_sync
 # Last effort, use O_SYNC
 dd if=/dev/zero of=$SCRATCH_MNT/tmp4 bs=4K oflag=sync >>$seqres.full 2>&1
 # Save space usage info to the full file
@@ -62,7 +62,7 @@ $DF_PROG $SCRATCH_MNT >>$seqres.full 2>&1
 
 # Should leave approx 256k free
 rm -f $SCRATCH_MNT/tmp1
-sync
+_scratch_sync
 echo "Post rm space:" >> $seqres.full
 $DF_PROG $SCRATCH_MNT >>$seqres.full 2>&1
 _freespace=`$DF_PROG -k $SCRATCH_MNT | tail -n 1 | awk '{print $5}'`
diff --git a/tests/generic/276 b/tests/generic/276
index 3c3e75df6..dfd2888ce 100755
--- a/tests/generic/276
+++ b/tests/generic/276
@@ -54,7 +54,7 @@ md5sum $testdir/file1 | _filter_scratch
 md5sum $testdir/file2 | _filter_scratch
 
 echo "CoW and unmount"
-sync
+_scratch_sync
 _dmerror_load_error_table
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $testdir/file2 \
 	>> $seqres.full 2>&1
diff --git a/tests/generic/278 b/tests/generic/278
index 5d9778f9f..e303a74ce 100755
--- a/tests/generic/278
+++ b/tests/generic/278
@@ -55,7 +55,7 @@ md5sum $testdir/file1 | _filter_scratch
 md5sum $testdir/file2 | _filter_scratch
 
 echo "CoW and unmount"
-sync
+_scratch_sync
 _dmerror_load_error_table
 urk=$($XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $testdir/file2 2>&1)
 echo $urk >> $seqres.full
diff --git a/tests/generic/279 b/tests/generic/279
index f4dac950c..599b4b6dc 100755
--- a/tests/generic/279
+++ b/tests/generic/279
@@ -53,7 +53,7 @@ md5sum $testdir/file1 | _filter_scratch
 md5sum $testdir/file2 | _filter_scratch
 
 echo "CoW and unmount"
-sync
+_scratch_sync
 _dmerror_load_error_table
 # Insulate ourselves against bash reporting the SIGBUS when we try to modify
 # the metadata.
diff --git a/tests/generic/281 b/tests/generic/281
index 6d48c4b14..474b8b73a 100755
--- a/tests/generic/281
+++ b/tests/generic/281
@@ -53,7 +53,7 @@ md5sum $testdir/file1 | _filter_scratch
 md5sum $testdir/file2 | _filter_scratch
 
 echo "CoW and unmount"
-sync
+_scratch_sync
 _dmerror_load_error_table
 # Insulate ourselves against bash reporting the SIGBUS when we try to modify
 # the metadata.
diff --git a/tests/generic/282 b/tests/generic/282
index b3eb48063..727978130 100755
--- a/tests/generic/282
+++ b/tests/generic/282
@@ -53,7 +53,7 @@ md5sum $testdir/file1 | _filter_scratch
 md5sum $testdir/file2 | _filter_scratch
 
 echo "CoW and unmount"
-sync
+_scratch_sync
 _dmerror_load_error_table
 # Insulate ourselves against bash reporting the SIGBUS when we try to modify
 # the metadata.
diff --git a/tests/generic/283 b/tests/generic/283
index b9104fe64..cdad47a24 100755
--- a/tests/generic/283
+++ b/tests/generic/283
@@ -54,7 +54,7 @@ md5sum $testdir/file1 | _filter_scratch
 md5sum $testdir/file2 | _filter_scratch
 
 echo "CoW and unmount"
-sync
+_scratch_sync
 _dmerror_load_error_table
 # Insulate ourselves against bash reporting the SIGBUS when we try to modify
 # the metadata.
diff --git a/tests/generic/315 b/tests/generic/315
index 83f46655f..cb660ed2d 100755
--- a/tests/generic/315
+++ b/tests/generic/315
@@ -41,7 +41,7 @@ fsize=`_get_filesize $TEST_DIR/testfile.$seq`
 
 # Truncate the file size back to 0
 truncate -s 0 $TEST_DIR/testfile.$seq
-sync
+_test_sync
 
 # Preallocated disk space should be released
 avail_done=`df -P $TEST_DIR | awk 'END {print $4}'`
diff --git a/tests/generic/317 b/tests/generic/317
index 177d88525..1afec6a75 100755
--- a/tests/generic/317
+++ b/tests/generic/317
@@ -73,7 +73,7 @@ _print_numeric_uid
 echo ""
 echo "*** Remounting ***"
 echo ""
-sync
+_scratch_sync
 _scratch_cycle_mount      >>$seqres.full 2>&1 || _fail "remount failed"
 
 _print_numeric_uid
diff --git a/tests/generic/318 b/tests/generic/318
index d31ad2b13..033c0611c 100755
--- a/tests/generic/318
+++ b/tests/generic/318
@@ -81,7 +81,7 @@ _print_getfacls
 
 echo "*** Remounting ***"
 echo ""
-sync
+_scratch_sync
 _scratch_cycle_mount      >>$seqres.full 2>&1 || _fail "remount failed"
 
 _print_getfacls
diff --git a/tests/generic/325 b/tests/generic/325
index 8fbd0d1d9..f85066337 100755
--- a/tests/generic/325
+++ b/tests/generic/325
@@ -42,7 +42,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0xff 0 256K" $SCRATCH_MNT/foo | _filter_xfs_io
 # Now sync the file data to disk using 'sync' and not an fsync. This is because
 # in btrfs the first fsync clears the btrfs inode full fsync flag, which must
 # be set when the first msync below happens in order to trigger the bug.
-sync
+_scratch_sync
 
 # Now update the first 4Kb and the last 4Kb of the file, using memory mapped IO
 # because an msync(), since the linux kernel commit
diff --git a/tests/generic/328 b/tests/generic/328
index 25e1f2a02..7071ded25 100755
--- a/tests/generic/328
+++ b/tests/generic/328
@@ -62,12 +62,12 @@ _report_quota_blocks $SCRATCH_MNT
 
 echo "Try to dio write the whole file"
 _pwrite_byte 0x62 0 $sz $testdir/file1 -d >> $seqres.full
-sync
+_scratch_sync
 _report_quota_blocks $SCRATCH_MNT
 
 echo "Try to write the whole file"
 _pwrite_byte 0x62 0 $sz $testdir/file3 >> $seqres.full
-sync
+_scratch_sync
 _report_quota_blocks $SCRATCH_MNT
 
 # success, all done
diff --git a/tests/generic/329 b/tests/generic/329
index ab37e047f..e4300f92c 100755
--- a/tests/generic/329
+++ b/tests/generic/329
@@ -57,7 +57,7 @@ md5sum $testdir/file2 | _filter_scratch
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
-sync
+_scratch_sync
 _dmerror_load_error_table
 $AIO_TEST -a $alignment -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
 _dmerror_load_working_table
diff --git a/tests/generic/330 b/tests/generic/330
index 4fa81f991..c67defc48 100755
--- a/tests/generic/330
+++ b/tests/generic/330
@@ -51,7 +51,7 @@ md5sum $testdir/file2 | _filter_scratch
 
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
-sync
+_scratch_sync
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
 $AIO_TEST -a $alignment -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
 _scratch_cycle_mount
diff --git a/tests/generic/331 b/tests/generic/331
index c1949e1b9..fe12ec4eb 100755
--- a/tests/generic/331
+++ b/tests/generic/331
@@ -57,7 +57,7 @@ md5sum $testdir/file2 | _filter_scratch
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
-sync
+_scratch_sync
 _dmerror_load_error_table
 $AIO_TEST -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -c "fdatasync" $testdir/file2
diff --git a/tests/generic/332 b/tests/generic/332
index 4a61e4a02..cb15e77bd 100755
--- a/tests/generic/332
+++ b/tests/generic/332
@@ -52,7 +52,7 @@ md5sum $testdir/file2 | _filter_scratch
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
-sync
+_scratch_sync
 $AIO_TEST -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
 _scratch_cycle_mount
 
diff --git a/tests/generic/335 b/tests/generic/335
index 280cf8538..f287b5150 100755
--- a/tests/generic/335
+++ b/tests/generic/335
@@ -38,7 +38,7 @@ mkdir $SCRATCH_MNT/c
 touch $SCRATCH_MNT/a/b/foo
 
 # Make sure everything is durably persisted.
-sync
+_scratch_sync
 
 # Now move our test file into a new parent directory.
 mv $SCRATCH_MNT/a/b/foo $SCRATCH_MNT/c/
diff --git a/tests/generic/336 b/tests/generic/336
index 478081978..06391a93f 100755
--- a/tests/generic/336
+++ b/tests/generic/336
@@ -43,7 +43,7 @@ ln $SCRATCH_MNT/a/foo $SCRATCH_MNT/b/foo_link
 touch $SCRATCH_MNT/b/bar
 
 # Make sure everything is durably persisted.
-sync
+_scratch_sync
 
 # Now delete one of the hard links of file foo and move file bar into c/
 unlink $SCRATCH_MNT/b/foo_link
diff --git a/tests/generic/341 b/tests/generic/341
index bea36e265..80fdcbac7 100755
--- a/tests/generic/341
+++ b/tests/generic/341
@@ -36,7 +36,7 @@ mkdir -p $SCRATCH_MNT/a/x
 $XFS_IO_PROG -f -c "pwrite -S 0xaf 0 32K" $SCRATCH_MNT/a/x/foo | _filter_xfs_io
 $XFS_IO_PROG -f -c "pwrite -S 0xba 0 32K" $SCRATCH_MNT/a/x/bar | _filter_xfs_io
 # Make sure everything done so far is durably persisted.
-sync
+_scratch_sync
 
 echo "File digests before power failure:"
 md5sum $SCRATCH_MNT/a/x/foo | _filter_scratch
diff --git a/tests/generic/342 b/tests/generic/342
index 3f5aca673..a7aca860b 100755
--- a/tests/generic/342
+++ b/tests/generic/342
@@ -40,7 +40,7 @@ _mount_flakey
 mkdir $SCRATCH_MNT/a
 $XFS_IO_PROG -f -c "pwrite -S 0xf1 0 16K" $SCRATCH_MNT/a/foo | _filter_xfs_io
 # Make sure everything done so far is durably persisted.
-sync
+_scratch_sync
 
 # Now rename file foo to bar and create a new file named foo under the same
 # directory. After a power failure we must see the two files.
diff --git a/tests/generic/343 b/tests/generic/343
index 6659f1988..97ff4f984 100755
--- a/tests/generic/343
+++ b/tests/generic/343
@@ -41,7 +41,7 @@ mkdir $SCRATCH_MNT/y/z
 touch $SCRATCH_MNT/y/foo2
 
 # Make sure everything is durably persisted.
-sync
+_scratch_sync
 
 # Now add a link to foo at directory x, move directory z and file foo2 from
 # directory y to directory x and fsync foo's inode. We expect that after a
diff --git a/tests/generic/347 b/tests/generic/347
index 7e1ea5d90..5c0e3f949 100755
--- a/tests/generic/347
+++ b/tests/generic/347
@@ -36,7 +36,7 @@ _workout()
 		$XFS_IO_PROG -f -c "pwrite -W 0 1M" $SCRATCH_MNT/file$I &>/dev/null
 	done
 
-	sync
+	_scratch_sync
 
 	_dmthin_grow  $GROW_SIZE
 
diff --git a/tests/generic/348 b/tests/generic/348
index eb0587d20..1905a6e6a 100755
--- a/tests/generic/348
+++ b/tests/generic/348
@@ -35,7 +35,7 @@ _mount_flakey
 
 mkdir $SCRATCH_MNT/testdir1
 # Make sure it's durably persisted.
-sync
+_scratch_sync
 
 # Create our symlinks and fsync their parent directories.
 # We test both the case where the parent directory is new (not yet durably
diff --git a/tests/generic/353 b/tests/generic/353
index ac5b97880..2114a74cb 100755
--- a/tests/generic/353
+++ b/tests/generic/353
@@ -48,7 +48,7 @@ cmp -s $extmap1 $extmap2 || echo "mismatched extent maps before sync"
 
 # sync and recheck, to make sure the fiemap doesn't change just
 # due to sync
-sync
+_scratch_sync
 $XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags > $extmap1
 $XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags > $extmap2
 
diff --git a/tests/generic/376 b/tests/generic/376
index cecd4e0d7..17a5f290b 100755
--- a/tests/generic/376
+++ b/tests/generic/376
@@ -36,7 +36,7 @@ _mount_flakey
 mkdir $SCRATCH_MNT/dir
 touch $SCRATCH_MNT/dir/foo
 # Make sure everything is durably persisted.
-sync
+_scratch_sync
 mv $SCRATCH_MNT/dir/foo $SCRATCH_MNT/dir/bar
 touch $SCRATCH_MNT/dir/foo
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir/bar
diff --git a/tests/generic/382 b/tests/generic/382
index 162da41d4..1634d85d2 100755
--- a/tests/generic/382
+++ b/tests/generic/382
@@ -56,7 +56,7 @@ do_test()
 	for ((i=0; i<30; i++));do
 		_user_do "echo -n > ${SCRATCH_MNT}/file${i}"
 	done
-	sync
+	_scratch_sync
 
 	rm -f ${SCRATCH_MNT}/* >/dev/null 2>&1
 }
diff --git a/tests/generic/387 b/tests/generic/387
index 544e7552a..c3b972496 100755
--- a/tests/generic/387
+++ b/tests/generic/387
@@ -37,7 +37,7 @@ done
 
 # consume all remaining free space
 dd if=/dev/zero of=$SCRATCH_MNT/space >/dev/null 2>&1
-sync
+_scratch_sync
 
 # fs is full now and fs internal operations may need some free space, for
 # example, in btrfs, transaction will need to reserve space first, so here free
diff --git a/tests/generic/391 b/tests/generic/391
index d19c48262..e41f644d3 100755
--- a/tests/generic/391
+++ b/tests/generic/391
@@ -38,7 +38,7 @@ for ((off = 0; off < num_extents * extent_size; off += extent_size)); do
 done
 
 # To reproduce the Btrfs bug, the extent map must not be cached in memory.
-sync
+_test_sync
 echo 3 > /proc/sys/vm/drop_caches
 
 "$here/src/dio-interleaved" "$extent_size" "$num_extents" "$testfile"
diff --git a/tests/generic/409 b/tests/generic/409
index ab7e7eb55..ac1b14ad6 100755
--- a/tests/generic/409
+++ b/tests/generic/409
@@ -58,7 +58,7 @@ fs_stress()
 		       -f getdents=1 \
 		       -f fiemap=1 \
 		       -d $target
-	sync
+	_sync_fs $target
 }
 
 # prepare some mountpoint dir
diff --git a/tests/generic/410 b/tests/generic/410
index f0f0921be..e0d0c57eb 100755
--- a/tests/generic/410
+++ b/tests/generic/410
@@ -66,7 +66,7 @@ fs_stress()
 		       -f getdents=1 \
 		       -f fiemap=1 \
 		       -d $target
-	sync
+	_sync_fs $target
 }
 
 # prepare some mountpoint dir
diff --git a/tests/generic/411 b/tests/generic/411
index 3b55b4f91..0a80554cd 100755
--- a/tests/generic/411
+++ b/tests/generic/411
@@ -49,7 +49,7 @@ fs_stress()
 		       -f getdents=1 \
 		       -f fiemap=1 \
 		       -d $target
-	sync
+	_sync_fs $target
 }
 
 # prepare some mountpoint dir
diff --git a/tests/generic/416 b/tests/generic/416
index 31a85c83f..f6a516fb6 100755
--- a/tests/generic/416
+++ b/tests/generic/416
@@ -52,7 +52,7 @@ _scratch_remount
 # remove all files with odd file names, which should free near half
 # of the space
 rm $SCRATCH_MNT/*[13579]
-sync
+_scratch_sync
 
 # We should be able to write at least 1/8 of the whole fs size
 # The number 1/8 is for btrfs, which only has about 47M for data.
diff --git a/tests/generic/422 b/tests/generic/422
index 71a0e5a86..ad37b9cea 100755
--- a/tests/generic/422
+++ b/tests/generic/422
@@ -34,7 +34,7 @@ $XFS_IO_PROG -f \
 touch $SCRATCH_MNT/foo4
 
 # Make sure everything done so far is durably persisted.
-sync
+_scratch_sync
 
 # Now overwrite the extent of the first file.
 $XFS_IO_PROG -c "pwrite -S 0xff 0 64K" $SCRATCH_MNT/foo1 | _filter_xfs_io
@@ -77,7 +77,7 @@ space_used > $SCRATCH_MNT/$seq.before
     cat $SCRATCH_MNT/$seq.before
 ) >> $seqres.full
 
-sync
+_scratch_sync
 
 # We expect the same file sizes reported by 'du' after writeback finishes.
 
diff --git a/tests/generic/425 b/tests/generic/425
index 3367a9567..352ae32d2 100755
--- a/tests/generic/425
+++ b/tests/generic/425
@@ -52,7 +52,7 @@ while [ $i -lt $max_attrs ]; do
 	$SETFATTR_PROG -n "user.$n" -v "$n" $testfile > $seqres.full 2>&1 || break
 	i=$((i + 1))
 done
-sync
+_scratch_sync
 
 echo "Check attr extent counts"
 f1=$(_count_attr_extents $testfile)
diff --git a/tests/generic/461 b/tests/generic/461
index 95dd6a34d..a2927f85e 100755
--- a/tests/generic/461
+++ b/tests/generic/461
@@ -27,7 +27,7 @@ load_dir=$SCRATCH_MNT/test
 
 _run_fsstress_bg -n10000000 -p $PROCS -d $load_dir
 sleep $SLEEP_TIME
-sync
+_scratch_sync
 
 # now shutdown and unmount
 sleep 5
diff --git a/tests/generic/474 b/tests/generic/474
index 2fa087a87..961d0f06f 100755
--- a/tests/generic/474
+++ b/tests/generic/474
@@ -36,7 +36,7 @@ _scratch_mount
 # accelerates syncfs on testing filesystem so that test case can finish
 # in 30 seconds.
 
-sync
+_scratch_sync
 
 # Large fs has a huge size .use_space file, will take long time on running
 # fssum $SCRATCH_MNT. So change the target path to a sub-dir of $SCRATCH_MNT.
@@ -47,7 +47,7 @@ $XFS_IO_PROG -f -c "pwrite 0 4K" $localdir/testfile >/dev/null 2>&1
 # fssum used for comparing checksum of test file(data & metedata),
 # exclude checking about atime, block structure, open error.
 $FSSUM_PROG -ugomAcdES -f -w $tmp.fssum $localdir
-$XFS_IO_PROG -c "syncfs" $localdir/testfile >/dev/null 2>&1
+_sync_fs $localdir/testfile
 _scratch_shutdown
 _scratch_cycle_mount
 $FSSUM_PROG -r $tmp.fssum $localdir
diff --git a/tests/generic/479 b/tests/generic/479
index 7f4aab4e7..650c921b8 100755
--- a/tests/generic/479
+++ b/tests/generic/479
@@ -53,7 +53,7 @@ run_test()
 		_fail "Invalid file type argument: $file_type"
 	esac
 	# Make sure everything done so far is durably persisted.
-	sync
+	_scratch_sync
 
 	# Create a file and fsync it just to create a journal/log. This file
 	# must be in the same directory as our special file "foo".
diff --git a/tests/generic/480 b/tests/generic/480
index 975c990ff..6c599446b 100755
--- a/tests/generic/480
+++ b/tests/generic/480
@@ -38,7 +38,7 @@ touch $SCRATCH_MNT/testdir/foo
 ln $SCRATCH_MNT/testdir/foo $SCRATCH_MNT/testdir/bar
 
 # Make sure everything done so far is durably persisted.
-sync
+_scratch_sync
 
 # Now remove of the links of our file and create a new file with the same name
 # and in the same parent directory, and finally fsync this new file.
diff --git a/tests/generic/483 b/tests/generic/483
index 60f9b1097..a71f96ad0 100755
--- a/tests/generic/483
+++ b/tests/generic/483
@@ -57,7 +57,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0xf1 0 256K" \
 	     $SCRATCH_MNT/baz >/dev/null
 
 # Make sure everything done so far is durably persisted.
-sync
+_scratch_sync
 
 # Allocate an extent beyond the size of the first test file and fsync it.
 $XFS_IO_PROG -c "falloc -k 256K 1M"\
diff --git a/tests/generic/489 b/tests/generic/489
index 62aa45a86..e76055fa4 100755
--- a/tests/generic/489
+++ b/tests/generic/489
@@ -39,7 +39,7 @@ $SETFATTR_PROG -n user.xa3 -v test $SCRATCH_MNT/foobar
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foobar
 
 # Call sync to commit all fileystem metadata.
-sync
+_scratch_sync
 
 $XFS_IO_PROG -c "pwrite -S 0xea 0 64K" \
 	     -c "fsync" \
diff --git a/tests/generic/502 b/tests/generic/502
index f6374f677..f488bd06c 100755
--- a/tests/generic/502
+++ b/tests/generic/502
@@ -46,7 +46,7 @@ touch $SCRATCH_MNT/testdir/foo
 ln $SCRATCH_MNT/testdir/foo $SCRATCH_MNT/testdir/bar
 
 # Make sure everything done so far is durably persisted.
-sync
+_scratch_sync
 
 # Now rename the first hard link (foo) to a new name and rename the second hard
 # link (bar) to the old name of the first hard link (foo).
diff --git a/tests/generic/505 b/tests/generic/505
index a25967352..eb44573b4 100755
--- a/tests/generic/505
+++ b/tests/generic/505
@@ -40,7 +40,7 @@ do_check()
 	touch $testfile
 
 	if [ "$1" == "sync" ]; then
-		sync
+		_scratch_sync
 	fi
 
 	chown 100 $testfile
diff --git a/tests/generic/506 b/tests/generic/506
index 9a41e5634..397e93d07 100755
--- a/tests/generic/506
+++ b/tests/generic/506
@@ -45,7 +45,7 @@ do_check()
 	touch $testfile
 
 	if [ "$1" == "sync" ]; then
-		sync
+		_scratch_sync
 	fi
 
 	$XFS_IO_PROG -x -c "chproj 100" $testfile
diff --git a/tests/generic/507 b/tests/generic/507
index 6678e50f7..b9e58067e 100755
--- a/tests/generic/507
+++ b/tests/generic/507
@@ -59,7 +59,7 @@ do_check()
 
 	if [ "$2" == "sync" ]; then
 		echo "sync" >> $seqres.full
-		sync
+		_scratch_sync
 	fi
 
 	echo "Test chattr +$1" >> $seqres.full
diff --git a/tests/generic/508 b/tests/generic/508
index 4e234160d..02023cf08 100755
--- a/tests/generic/508
+++ b/tests/generic/508
@@ -44,7 +44,7 @@ do_check()
 	touch $testfile
 
 	if [ "$1" == "sync" ]; then
-		sync
+		_scratch_sync
 	fi
 
 	before=`$XFS_IO_PROG -f $testfile -c "statx -v" | grep btime`
diff --git a/tests/generic/510 b/tests/generic/510
index 5ea0e0677..abf18f1bf 100755
--- a/tests/generic/510
+++ b/tests/generic/510
@@ -39,7 +39,7 @@ mkdir $SCRATCH_MNT/testdir/B
 touch $SCRATCH_MNT/testdir/B/bar
 
 # Make sure everything done so far is durably persisted.
-sync
+_scratch_sync
 
 # Now move our file bar from directory B to directory A and then replace
 # directory B with directory A, also renaming directory A to B. Finally
diff --git a/tests/generic/520 b/tests/generic/520
index 00fa050e2..f2523fca2 100755
--- a/tests/generic/520
+++ b/tests/generic/520
@@ -125,7 +125,7 @@ test_link_sync()
 	mkdir -p "${dest%/*}"
 	touch $src
 	ln $src $dest
-	sync
+	_scratch_sync
 	before=`stat "$stat_opt" $src`
 
 	check_consistency $src 0
diff --git a/tests/generic/526 b/tests/generic/526
index 7d47cf111..af77ccaff 100755
--- a/tests/generic/526
+++ b/tests/generic/526
@@ -43,7 +43,7 @@ echo -n "foo" > $SCRATCH_MNT/testdir/fname1
 echo -n "hello" > $SCRATCH_MNT/testdir/fname2
 
 # Make sure everything done so far is durably persisted.
-sync
+_scratch_sync
 
 # Rename and link files such that one new name corresponds to the name of
 # another renamed file and one new file has the old name of one of the renamed
diff --git a/tests/generic/527 b/tests/generic/527
index 2ba1f319b..90555077f 100755
--- a/tests/generic/527
+++ b/tests/generic/527
@@ -49,7 +49,7 @@ ln $SCRATCH_MNT/testdir2/zz $SCRATCH_MNT/testdir2/zz_link
 echo -n "hello" > $SCRATCH_MNT/testdir2/a
 
 # Make sure everything done so far is durably persisted.
-sync
+_scratch_sync
 
 # Rename, remove and link files such that one new name corresponds to the name
 # of a deleted file and one new file has the old name of the renamed file. Then
diff --git a/tests/generic/535 b/tests/generic/535
index c2338da6b..98e2f2384 100755
--- a/tests/generic/535
+++ b/tests/generic/535
@@ -59,7 +59,7 @@ do_check()
 	echo "Test chmod $target" >> $seqres.full
 
 	chmod 777 $target
-	sync
+	_scratch_sync
 
 	chmod 755 $target
 	$XFS_IO_PROG $target -c "fsync"
diff --git a/tests/generic/546 b/tests/generic/546
index 972886858..ab4ea657e 100755
--- a/tests/generic/546
+++ b/tests/generic/546
@@ -47,7 +47,7 @@ _pwrite_byte 0x00 0 512m "$SCRATCH_MNT/padding" >> $seqres.full 2>&1
 
 # Sync to ensure that padding file reach disk so that at log recovery we
 # still have no data space
-sync
+_scratch_sync
 
 # This should not fail
 _pwrite_byte 0xcd 1m 16m "$SCRATCH_MNT/foobar" >> $seqres.full
diff --git a/tests/generic/556 b/tests/generic/556
index d3396ae3b..279ff58b3 100755
--- a/tests/generic/556
+++ b/tests/generic/556
@@ -366,7 +366,7 @@ test_toplevel_dir_rename()
 	# 'f2fs: don't use casefolded comparison for "." and ".."'.
 	mkdir ${dir}
 	_casefold_set_attr ${dir}
-	sync
+	_scratch_sync
 	echo 2 > /proc/sys/vm/drop_caches
 	mv ${dir} ${dir}.new
 }
diff --git a/tests/generic/579 b/tests/generic/579
index 4187ab0f0..d5fab4892 100755
--- a/tests/generic/579
+++ b/tests/generic/579
@@ -86,7 +86,7 @@ done
 (
 	while [ ! -e $tmp.done ]; do
 		sleep 2.$((RANDOM % 100))
-		sync && echo 3 > /proc/sys/vm/drop_caches
+		_scratch_sync && echo 3 > /proc/sys/vm/drop_caches
 	done
 ) &
 
diff --git a/tests/generic/589 b/tests/generic/589
index 969a8ac61..b5860070b 100755
--- a/tests/generic/589
+++ b/tests/generic/589
@@ -48,7 +48,7 @@ fs_stress()
 	local target=$1
 
 	_run_fsstress -n 50 -p 3 -d $target
-	sync
+	_sync_fs $target
 }
 
 # prepare some mountpoint dir
diff --git a/tests/generic/599 b/tests/generic/599
index e1454584f..a8eb93709 100755
--- a/tests/generic/599
+++ b/tests/generic/599
@@ -24,7 +24,7 @@ _scratch_mount
 
 localdir=$SCRATCH_MNT/dir
 mkdir $localdir
-sync
+_scratch_sync
 
 # fssum used for comparing checksum of test file(data & metedata),
 # exclude checking about atime, block structure, open error.
diff --git a/tests/generic/610 b/tests/generic/610
index 22f28c6df..00a676e6e 100755
--- a/tests/generic/610
+++ b/tests/generic/610
@@ -30,7 +30,7 @@ $here/src/punch-alternating $SCRATCH_MNT/foobar >>$seqres.full
 
 # For btrfs, trigger a transaction commit to force metadata COW for the
 # following fallocate zero range operation.
-sync
+_scratch_sync
 
 $XFS_IO_PROG -c "fzero 0 100M" $SCRATCH_MNT/foobar
 
diff --git a/tests/generic/628 b/tests/generic/628
index 8fd44364c..6f891abc2 100755
--- a/tests/generic/628
+++ b/tests/generic/628
@@ -54,7 +54,7 @@ $XFS_IO_PROG -f -c 'pwrite -S 0x59 0 1m -b 1m' $SCRATCH_MNT/c >> $seqres.full
 _cp_reflink $SCRATCH_MNT/a $SCRATCH_MNT/e
 _cp_reflink $SCRATCH_MNT/c $SCRATCH_MNT/d
 touch $SCRATCH_MNT/b
-sync
+_scratch_sync
 
 # Test that reflink forces dirty data/metadata to disk when destination file
 # opened with O_SYNC
@@ -81,7 +81,7 @@ rm -f $SCRATCH_MNT/b $SCRATCH_MNT/d
 _cp_reflink $SCRATCH_MNT/c $SCRATCH_MNT/d
 touch $SCRATCH_MNT/b
 chattr +S $SCRATCH_MNT/b $SCRATCH_MNT/d
-sync
+_scratch_sync
 
 # Test that reflink forces dirty data/metadata to disk when destination file
 # has the sync iflag set
diff --git a/tests/generic/629 b/tests/generic/629
index 92b7839a0..1088e50e4 100755
--- a/tests/generic/629
+++ b/tests/generic/629
@@ -50,7 +50,7 @@ md5sum $SCRATCH_MNT/0 | _filter_scratch
 # Set up initial files for copy test
 $XFS_IO_PROG -f -c 'pwrite -S 0x58 0 1m -b 1m' $SCRATCH_MNT/a >> $seqres.full
 touch $SCRATCH_MNT/b
-sync
+_scratch_sync
 
 # Test that unaligned copy file range forces dirty data/metadata to disk when
 # destination file opened with O_SYNC
@@ -66,7 +66,7 @@ md5sum $SCRATCH_MNT/a $SCRATCH_MNT/b | _filter_scratch
 rm -f $SCRATCH_MNT/b
 touch $SCRATCH_MNT/b
 chattr +S $SCRATCH_MNT/b
-sync
+_scratch_sync
 
 # Test that unaligned copy file range forces dirty data/metadata to disk when
 # destination file has the sync iflag set
diff --git a/tests/generic/640 b/tests/generic/640
index 038dde975..c3b33746e 100755
--- a/tests/generic/640
+++ b/tests/generic/640
@@ -38,7 +38,7 @@ mkdir $SCRATCH_MNT/B
 echo -n "hello world" > $SCRATCH_MNT/A/foo
 
 # Persist everything done so far.
-sync
+_scratch_sync
 
 # Add some new file to directory A and fsync the directory.
 touch $SCRATCH_MNT/A/bar
diff --git a/tests/generic/673 b/tests/generic/673
index 1230b51e1..8f6def9c7 100755
--- a/tests/generic/673
+++ b/tests/generic/673
@@ -28,7 +28,7 @@ setup_testfile() {
 	_pwrite_byte 0x58 0 1m $SCRATCH_MNT/a >> $seqres.full
 	_pwrite_byte 0x57 0 1m $SCRATCH_MNT/b >> $seqres.full
 	chmod a+r $SCRATCH_MNT/b
-	sync
+	_scratch_sync
 }
 
 commit_and_check() {
diff --git a/tests/generic/674 b/tests/generic/674
index 2e395290a..1b711f27f 100755
--- a/tests/generic/674
+++ b/tests/generic/674
@@ -29,7 +29,7 @@ setup_testfile() {
 	_pwrite_byte 0x58 0 1m $SCRATCH_MNT/a >> $seqres.full
 	_pwrite_byte 0x58 0 1m $SCRATCH_MNT/b >> $seqres.full
 	chmod a+r $SCRATCH_MNT/b
-	sync
+	_scratch_sync
 }
 
 commit_and_check() {
diff --git a/tests/generic/675 b/tests/generic/675
index 7c062db81..e66de84b5 100755
--- a/tests/generic/675
+++ b/tests/generic/675
@@ -33,7 +33,7 @@ setup_testfile() {
 	_pwrite_byte 0x57 0 1m $SCRATCH_MNT/b >> $seqres.full
 	chmod a+rwx $SCRATCH_MNT/a $SCRATCH_MNT/b
 	$SETCAP_PROG cap_setgid,cap_setuid+ep $SCRATCH_MNT/a
-	sync
+	_scratch_sync
 }
 
 commit_and_check() {
diff --git a/tests/generic/677 b/tests/generic/677
index f2081c34c..86099454f 100755
--- a/tests/generic/677
+++ b/tests/generic/677
@@ -62,7 +62,7 @@ $XFS_IO_PROG -c "falloc -k 20M 1M" $SCRATCH_MNT/foo
 # On btrfs this commits the current transaction and it makes all the created
 # extents to have a generation lower than the generation of the transaction used
 # by the next write and fsync.
-sync
+_scratch_sync
 
 # Now overwrite only the first extent.
 # On btrfs, due to COW (both data and metadata), that results in modifying only
diff --git a/tests/generic/683 b/tests/generic/683
index cf1ebbc44..cc9a9786b 100755
--- a/tests/generic/683
+++ b/tests/generic/683
@@ -36,7 +36,7 @@ chmod a+rw $junk_dir/
 setup_testfile() {
 	rm -f $junk_file
 	_pwrite_byte 0x58 0 192k $junk_file >> $seqres.full
-	sync
+	_test_sync
 }
 
 commit_and_check() {
diff --git a/tests/generic/684 b/tests/generic/684
index e1eb4e118..2ca036fe5 100755
--- a/tests/generic/684
+++ b/tests/generic/684
@@ -36,7 +36,7 @@ chmod a+rw $junk_dir/
 setup_testfile() {
 	rm -f $junk_file
 	_pwrite_byte 0x58 0 192k $junk_file >> $seqres.full
-	sync
+	_test_sync
 }
 
 commit_and_check() {
diff --git a/tests/generic/685 b/tests/generic/685
index bec2c5a0b..de07a798a 100755
--- a/tests/generic/685
+++ b/tests/generic/685
@@ -36,7 +36,7 @@ chmod a+rw $junk_dir/
 setup_testfile() {
 	rm -f $junk_file
 	_pwrite_byte 0x58 0 192k $junk_file >> $seqres.full
-	sync
+	_test_sync
 }
 
 commit_and_check() {
diff --git a/tests/generic/686 b/tests/generic/686
index efcc3f610..fc6761fe6 100755
--- a/tests/generic/686
+++ b/tests/generic/686
@@ -36,7 +36,7 @@ chmod a+rw $junk_dir/
 setup_testfile() {
 	rm -f $junk_file
 	_pwrite_byte 0x58 0 192k $junk_file >> $seqres.full
-	sync
+	_test_sync
 }
 
 commit_and_check() {
diff --git a/tests/generic/687 b/tests/generic/687
index e05f0fdcd..82dce88b8 100755
--- a/tests/generic/687
+++ b/tests/generic/687
@@ -36,7 +36,7 @@ chmod a+rw $junk_dir/
 setup_testfile() {
 	rm -f $junk_file
 	_pwrite_byte 0x58 0 192k $junk_file >> $seqres.full
-	sync
+	_test_sync
 }
 
 commit_and_check() {
diff --git a/tests/generic/688 b/tests/generic/688
index 9c19356d8..e491d5cf3 100755
--- a/tests/generic/688
+++ b/tests/generic/688
@@ -40,7 +40,7 @@ setup_testfile() {
 	touch $junk_file
 	chmod a+rwx $junk_file
 	$SETCAP_PROG cap_setgid,cap_setuid+ep $junk_file
-	sync
+	_test_sync
 }
 
 commit_and_check() {
diff --git a/tests/generic/690 b/tests/generic/690
index ba0da30d3..ef5bd1983 100755
--- a/tests/generic/690
+++ b/tests/generic/690
@@ -52,7 +52,7 @@ _mount_flakey
 mkdir "$SCRATCH_MNT"/testdir
 
 # Commit the current transaction and persist the directory.
-sync
+_scratch_sync
 
 # Create a file in the test directory, so that the next fsync on the directory
 # actually does something (it logs the directory).
diff --git a/tests/generic/694 b/tests/generic/694
index a68fc5230..e5c4f88c5 100755
--- a/tests/generic/694
+++ b/tests/generic/694
@@ -39,7 +39,7 @@ fi
 
 # make sure indirect block reservations and other temporary block reservations
 # are released before sampling i_blocks
-sync $junk_file
+_test_sync
 
 iblocks=`stat -c '%b' $junk_file`
 
diff --git a/tests/generic/695 b/tests/generic/695
index 8179d59a0..df81fdb7f 100755
--- a/tests/generic/695
+++ b/tests/generic/695
@@ -51,7 +51,7 @@ $XFS_IO_PROG -f -c "truncate 12M" \
 	     $SCRATCH_MNT/foobar | _filter_xfs_io
 
 # Persist everything, commit the filesystem's transaction.
-sync
+_scratch_sync
 
 # Now punch two holes in the file:
 #
diff --git a/tests/generic/703 b/tests/generic/703
index 8ee1d558c..2bace19d6 100755
--- a/tests/generic/703
+++ b/tests/generic/703
@@ -70,7 +70,7 @@ fi
 $XFS_IO_PROG -c "falloc 0 256M" $test_file
 
 # Persist everything, make sure the file exists after power failure.
-sync
+_scratch_sync
 
 echo -e "Running fio with config:\n" >> $seqres.full
 cat $fio_config >> $seqres.full
diff --git a/tests/generic/716 b/tests/generic/716
index a2b86225a..d3923dc1d 100755
--- a/tests/generic/716
+++ b/tests/generic/716
@@ -36,7 +36,7 @@ filesnap() {
 mkfile() {
 	rm -f $dir/a
 	_pwrite_byte 0x58 0 $((blksz * nrblks)) $dir/a >> $seqres.full
-	sync
+	_test_sync
 }
 
 dir=$TEST_DIR/test-$seq
diff --git a/tests/generic/718 b/tests/generic/718
index ed3a1fee5..4d322b224 100755
--- a/tests/generic/718
+++ b/tests/generic/718
@@ -31,7 +31,7 @@ nrblks=64
 # Create some 4M files to test exchangerange
 _pwrite_byte 0x58 0 $((blksz * nrblks)) $dir/a >> $seqres.full
 _pwrite_byte 0x59 0 $((blksz * nrblks)) $dir/b >> $seqres.full
-sync
+_test_sync
 md5sum $dir/a $dir/b | _filter_test_dir
 
 # Set FSIZE to twice the blocksize (IOWs, 128k)
diff --git a/tests/generic/719 b/tests/generic/719
index c82cf9552..9cd6eed91 100755
--- a/tests/generic/719
+++ b/tests/generic/719
@@ -34,7 +34,7 @@ filesnap() {
 mkfile() {
 	rm -f $dir/a
 	_pwrite_byte 0x58 0 $((blksz * nrblks)) $dir/a >> $seqres.full
-	sync
+	_test_sync
 }
 
 dir=$TEST_DIR/test-$seq
diff --git a/tests/generic/721 b/tests/generic/721
index 98505aac9..a9565f189 100755
--- a/tests/generic/721
+++ b/tests/generic/721
@@ -35,7 +35,7 @@ mkfile() {
 	rm -f $dir/a
 	_pwrite_byte 0x58 0 $((blksz * nrblks)) $dir/a >> $seqres.full
 	chown $qa_user $dir/a $dir/
-	sync
+	_test_sync
 }
 
 dir=$TEST_DIR/test-$seq
diff --git a/tests/generic/725 b/tests/generic/725
index e1db83b5e..3a9005ddf 100755
--- a/tests/generic/725
+++ b/tests/generic/725
@@ -31,7 +31,7 @@ _require_congruent_file_oplen $SCRATCH_MNT 65536
 
 # Create original file
 _pwrite_byte 0x58 0 1m $SCRATCH_MNT/a >> $seqres.full
-sync
+_scratch_sync
 md5sum $SCRATCH_MNT/a | _filter_scratch
 
 # Test atomic scatter-gather file commits.
diff --git a/tests/generic/726 b/tests/generic/726
index 00071b1d0..131ac5b50 100755
--- a/tests/generic/726
+++ b/tests/generic/726
@@ -35,7 +35,7 @@ chmod a+rw $SCRATCH_MNT/
 setup_testfile() {
 	rm -f $SCRATCH_MNT/a
 	_pwrite_byte 0x58 0 1m $SCRATCH_MNT/a >> $seqres.full
-	sync
+	_scratch_sync
 }
 
 commit_and_check() {
diff --git a/tests/generic/727 b/tests/generic/727
index dbed1d45c..ee7ed9760 100755
--- a/tests/generic/727
+++ b/tests/generic/727
@@ -42,7 +42,7 @@ setup_testfile() {
 	_pwrite_byte 0x57 0 1m $SCRATCH_MNT/b >> $seqres.full
 	chmod a+rw $SCRATCH_MNT/a $SCRATCH_MNT/b
 	$SETCAP_PROG cap_setgid,cap_setuid+ep $SCRATCH_MNT/a
-	sync
+	_scratch_sync
 }
 
 commit_and_check() {
diff --git a/tests/generic/735 b/tests/generic/735
index 1aeeb9a42..9bbdf3a17 100755
--- a/tests/generic/735
+++ b/tests/generic/735
@@ -42,7 +42,7 @@ $XFS_IO_PROG -f -c "finsert 1M ${finsert_len}" "${SCRATCH_MNT}/file" >> $seqres.
 # Filling up the free space ensures that the pre-allocated space is the reserved space.
 nr_free=$(stat -f -c '%f' ${SCRATCH_MNT})
 _fill_fs $((nr_free * file_blksz)) ${SCRATCH_MNT}/fill $file_blksz 0 >> $seqres.full 2>&1
-sync
+_scratch_sync
 
 # Remove reserved space to gain free space for allocation
 rm -f ${SCRATCH_MNT}/tmp
diff --git a/tests/generic/738 b/tests/generic/738
index 4da2d8879..6f1ea7f8f 100755
--- a/tests/generic/738
+++ b/tests/generic/738
@@ -36,7 +36,7 @@ $XFS_IO_PROG -fc "pwrite 0 64k" $SCRATCH_MNT/testfile >> $seqres.full
 for i in $(seq 0 1024); do
 	create_eof_block_file $SCRATCH_MNT/$i
 done
-sync
+_scratch_sync
 xfs_freeze -f $SCRATCH_MNT
 
 # This will hang if bug reproduces
diff --git a/tests/generic/745 b/tests/generic/745
index bed43578a..62624b15b 100755
--- a/tests/generic/745
+++ b/tests/generic/745
@@ -51,7 +51,7 @@ _mount_flakey
 # Create the test file with some initial data and make sure everything is
 # durably persisted.
 $XFS_IO_PROG -f -c "pwrite -S 0xaa 0 32k" $SCRATCH_MNT/foo | _filter_xfs_io
-sync
+_scratch_sync
 
 # Add many small xattrs to our file.
 # We create such a large amount because it's needed to trigger the issue found
@@ -66,7 +66,7 @@ done
 
 # Sync the filesystem to force a commit of the current btrfs transaction, this
 # is a necessary condition to trigger the bug on btrfs.
-sync
+_scratch_sync
 
 # Now update our file's data and fsync the file.
 # After a successful fsync, if the fsync log/journal is replayed we expect to
diff --git a/tests/generic/746 b/tests/generic/746
index 651affe07..5734f254d 100755
--- a/tests/generic/746
+++ b/tests/generic/746
@@ -170,7 +170,7 @@ for i in `seq 1 10`; do
 done
 
 # Get reference fiemap, this can contain i.e. uninitialized inode table
-sync
+_sync_fs $loop_mnt
 get_holes > $fiemap_ref
 
 # Delete some files
@@ -184,7 +184,7 @@ echo "done."
 
 echo -n "Detecting interesting holes in image..."
 # Get after-trim fiemap
-sync
+_sync_fs $loop_mnt
 get_holes > $fiemap_after
 echo "done."
 
diff --git a/tests/generic/747 b/tests/generic/747
index b92098f9f..448341866 100755
--- a/tests/generic/747
+++ b/tests/generic/747
@@ -57,7 +57,7 @@ _used_percent() {
 _delete_random_file() {
 	local to_delete=$(find ${SCRATCH_MNT} -type f | shuf | head -1)
 	rm $to_delete
-	sync ${SCRATCH_MNT}
+	_scratch_sync
 }
 
 _get_random_fsz() {
@@ -110,7 +110,7 @@ echo "Starting mixed write/delete test using buffered IO"
 _mixed_write_delete ""
 
 echo "Syncing"
-sync ${SCRATCH_MNT}/*
+_scratch_sync
 
 echo "Done, all good"
 
diff --git a/tests/generic/749 b/tests/generic/749
index 8b2c7feff..fc7477380 100755
--- a/tests/generic/749
+++ b/tests/generic/749
@@ -100,7 +100,7 @@ do_mmap_tests()
 	$XFS_IO_PROG -f -c "pwrite -S 0xaa -b 512 $offset $len" \
 		$test_file >> $seqres.full
 
-	sync
+	_scratch_sync
 	new_filelen=$(_get_filesize $test_file)
 	map_len=$(_round_up_to_page_boundary $new_filelen)
 	csum_orig="$(_md5_checksum $test_file)"
@@ -141,7 +141,7 @@ do_mmap_tests()
 			-c "mmap -w 0 $map_len" \
 			-c "mwrite $new_filelen $zero_filled_data_len" \
 			-c "munmap"
-		sync
+		_scratch_sync
 		csum_post="$(_md5_checksum $test_file)"
 		if [[ "$csum_orig" != "$csum_post" ]]; then
 			let failed=$failed+1
diff --git a/tests/xfs/016 b/tests/xfs/016
index 1abc06c42..f8076cc8d 100755
--- a/tests/xfs/016
+++ b/tests/xfs/016
@@ -101,9 +101,9 @@ _log_traffic()
     while [ $count -ge 0 ]
     do
 	touch $out
-	sync
+	_scratch_sync
 	rm $out
-	sync
+	_scratch_sync
 	let "count = count - 1"
     done
 
diff --git a/tests/xfs/052 b/tests/xfs/052
index adeab5380..af6e938e0 100755
--- a/tests/xfs/052
+++ b/tests/xfs/052
@@ -54,7 +54,7 @@ fi
 
 # create 100 (fs-blocksize) blocks
 _file_as_id $SCRATCH_MNT/foo $id $type $dbsize 220
-sync
+_scratch_sync
 
 # set limit at 1001 (1k) blocks
 bsoft=1001
diff --git a/tests/xfs/110 b/tests/xfs/110
index 0c8c87ea9..fc51d183f 100755
--- a/tests/xfs/110
+++ b/tests/xfs/110
@@ -43,7 +43,7 @@ do
 done
 wait
 
-sync
+_scratch_sync
 
 I=10030585
 E=10030599
diff --git a/tests/xfs/118 b/tests/xfs/118
index 73e429384..b5a1eabf7 100755
--- a/tests/xfs/118
+++ b/tests/xfs/118
@@ -38,7 +38,7 @@ echo "Silence is golden"
 # preallocation added.  Let's say... 64k free chunks.
 
 $XFS_IO_PROG -fs -c "falloc 0 40000k" $SCRATCH_MNT/fill >> $seqres.full 2>&1
-sync
+_scratch_sync
 
 dd if=/dev/zero of=$SCRATCH_MNT/remainder oflag=direct > /dev/null 2>&1
 
@@ -55,7 +55,7 @@ for I in `seq 1 64`; do
 						>> $seqres.full 2>&1
 done
 # sync to get extents on disk so fsr sees them
-sync
+_scratch_sync
 
 # Free up some space for defragmentation temp file
 rm -f $SCRATCH_MNT/fill
diff --git a/tests/xfs/119 b/tests/xfs/119
index 334d06934..7c1cd6a50 100755
--- a/tests/xfs/119
+++ b/tests/xfs/119
@@ -30,7 +30,7 @@ _require_scratch
 _require_freeze
 
 # this may hang
-sync
+_scratch_sync
 
 export MKFS_OPTIONS="-l version=2,su=64k"
 logblks=$(_scratch_find_xfs_min_logblocks)
diff --git a/tests/xfs/128 b/tests/xfs/128
index 0f1905295..0bfda0e06 100755
--- a/tests/xfs/128
+++ b/tests/xfs/128
@@ -42,7 +42,7 @@ blksz_factor=$((blksz / real_blksz))
 # preallocate space to try to produce a single extent.
 $XFS_IO_PROG -f -c "falloc 0 $((blks * blksz))" $testdir/file1 >> $seqres.full
 _pwrite_byte 0x61 0 $((blks * blksz)) $testdir/file1 >> $seqres.full
-sync
+_scratch_sync
 
 nextents=$($XFS_IO_PROG -c 'stat' $testdir/file1 | grep 'fsxattr.nextents' | awk '{print $3}')
 
diff --git a/tests/xfs/133 b/tests/xfs/133
index 39f4f74ae..c9bae5d92 100755
--- a/tests/xfs/133
+++ b/tests/xfs/133
@@ -49,7 +49,7 @@ fi
 echo "Remount, try to append"
 _scratch_mount
 dd if=/dev/zero of=$testdir/a bs=512 count=1 oflag=append conv=notrunc >> $seqres.full 2>&1 || echo "Write did not succeed (ok)."
-sync
+_scratch_sync
 
 # success, all done
 status=0
diff --git a/tests/xfs/134 b/tests/xfs/134
index b86265211..77505718a 100755
--- a/tests/xfs/134
+++ b/tests/xfs/134
@@ -52,7 +52,7 @@ fi
 echo "Remount, try to append"
 _scratch_mount
 dd if=/dev/zero of=$testdir/a bs=512 count=1 oflag=direct,append conv=notrunc >> $seqres.full 2>&1 || echo "Write did not succeed (ok)."
-sync
+_scratch_sync
 
 # success, all done
 status=0
diff --git a/tests/xfs/161 b/tests/xfs/161
index 948121c05..e13a646a5 100755
--- a/tests/xfs/161
+++ b/tests/xfs/161
@@ -51,7 +51,7 @@ lim_bhard=$(( 100 * blksz ))
 # Force the block counters for uid 1 and 2 above zero
 _pwrite_byte 0x61 0 $filesz $SCRATCH_MNT/a >> $seqres.full
 _pwrite_byte 0x61 0 $filesz $SCRATCH_MNT/b >> $seqres.full
-sync
+_scratch_sync
 chown 1 $SCRATCH_MNT/a
 chown 2 $SCRATCH_MNT/b
 
diff --git a/tests/xfs/176 b/tests/xfs/176
index 8d58590fd..e3fa87c43 100755
--- a/tests/xfs/176
+++ b/tests/xfs/176
@@ -151,7 +151,7 @@ for ((ino = icluster_ino; ino < icluster_ino + XFS_INODES_PER_CHUNK; ino++)); do
 	find $SCRATCH_MNT/urk/ -inum "$ino" -print0 | xargs -r -0 mv -t $SCRATCH_MNT/save/
 done
 rm -rf $SCRATCH_MNT/urk/ $SCRATCH_MNT/save/*/*
-sync
+_scratch_sync
 $XFS_IO_PROG -c 'fsmap -vvvvv' $SCRATCH_MNT &>> $seqres.full
 
 # Propose shrinking the filesystem such that the end of the fs ends up in the
diff --git a/tests/xfs/195 b/tests/xfs/195
index f965d9c38..9d23c32dc 100755
--- a/tests/xfs/195
+++ b/tests/xfs/195
@@ -56,7 +56,7 @@ $CHATTR_PROG +d $TEST_DIR/d/t
 _do_dump
 
 echo "Dump exclude flag set, after sync (should be skipped)"
-sync
+_test_sync
 _do_dump
 
 # success, all done
diff --git a/tests/xfs/201 b/tests/xfs/201
index 60cc84ed2..ffd05f8a9 100755
--- a/tests/xfs/201
+++ b/tests/xfs/201
@@ -64,8 +64,8 @@ do_pwrite 5000 6455 $min_align
 do_pwrite 1728 4999 $min_align
 do_pwrite 0 1727 $min_align
 
-sync
-sync
+_scratch_sync
+_scratch_sync
 
 # and truncate it again
 > $SCRATCH_MNT/bigfile
diff --git a/tests/xfs/212 b/tests/xfs/212
index 54ece22ab..51d211164 100755
--- a/tests/xfs/212
+++ b/tests/xfs/212
@@ -52,7 +52,7 @@ echo "CoW and leave leftovers"
 $XFS_IO_PROG -f -c "extsize" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $((filesize - 1)) 1" -c "fsync" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $((filesize - 1)) 1" -c "fsync" $testdir/file2.chk >> $seqres.full
-sync
+_scratch_sync
 
 echo "Crash and recover"
 $XFS_IO_PROG -x -c "shutdown" $testdir/file2 >> $seqres.full
diff --git a/tests/xfs/227 b/tests/xfs/227
index 3f01b175e..2ad910cbd 100755
--- a/tests/xfs/227
+++ b/tests/xfs/227
@@ -60,7 +60,7 @@ fragment_freespace()
 		$XFS_IO_PROG -f -c "unresvsp ${i}k 4k" $_file \
 					> /dev/null 2>&1
 	done
-	sync
+	_scratch_sync
 
 	# and now use up all the remaining extents larger than 3 blocks
 	$XFS_IO_PROG -fs -c "resvsp 0 4m" $_file.large > /dev/null 2>&1
diff --git a/tests/xfs/231 b/tests/xfs/231
index c01682fa8..ea494a152 100755
--- a/tests/xfs/231
+++ b/tests/xfs/231
@@ -71,7 +71,7 @@ seq 2 2 $((nr - 1)) | while read f; do
 	$XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz * f - 1)) 1" $testdir/file2 >> $seqres.full
 	$XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz * f - 1)) 1" $testdir/file2.chk >> $seqres.full
 done
-sync
+_scratch_sync
 
 echo "Wait for CoW expiration"
 sleep 3
@@ -88,7 +88,7 @@ seq 2 2 $((nr - 1)) | while read f; do
 	$XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz * f)) 1" $testdir/file2 >> $seqres.full
 	$XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz * f)) 1" $testdir/file2.chk >> $seqres.full
 done
-sync
+_scratch_sync
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/232 b/tests/xfs/232
index c7eba95a4..0eea2c098 100755
--- a/tests/xfs/232
+++ b/tests/xfs/232
@@ -74,7 +74,7 @@ seq 2 2 $((nr - 1)) | while read f; do
 	$XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz * f - 1)) 1" $testdir/file2 >> $seqres.full
 	$XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz * f - 1)) 1" $testdir/file2.chk >> $seqres.full
 done
-sync
+_scratch_sync
 
 echo "Wait for CoW expiration"
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz * 2)) 1" $testdir/file2 >> $seqres.full
@@ -92,7 +92,7 @@ seq 2 2 $((nr - 1)) | while read f; do
 	$XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz * f)) 1" $testdir/file2 >> $seqres.full
 	$XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz * f)) 1" $testdir/file2.chk >> $seqres.full
 done
-sync
+_scratch_sync
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/234 b/tests/xfs/234
index 4d6e30c0a..e57bf38cb 100755
--- a/tests/xfs/234
+++ b/tests/xfs/234
@@ -39,7 +39,7 @@ echo "Create the original file blocks"
 blksz="$(_get_block_size $testdir)"
 nr_blks=$((4 * blksz / 12))
 _pwrite_byte 0x61 0 $((blksz * nr_blks)) $testdir/file1 >> $seqres.full
-sync
+_scratch_sync
 
 echo "Punch every other block"
 seq 1 2 $((nr_blks - 1)) | while read nr; do
diff --git a/tests/xfs/236 b/tests/xfs/236
index a374a300d..29cab3190 100755
--- a/tests/xfs/236
+++ b/tests/xfs/236
@@ -38,7 +38,7 @@ nr_blks=$((8 * blksz / 12))
 for i in 1 2 x; do
 	_pwrite_byte 0x61 0 $((blksz * nr_blks)) $testdir/file1 >> $seqres.full
 	_pwrite_byte 0x62 0 $((blksz * nr_blks)) $testdir/file2 >> $seqres.full
-	sync
+	_scratch_sync
 
 	echo "$i: Reflink every other block"
 	seq 1 2 $((nr_blks - 1)) | while read nr; do
diff --git a/tests/xfs/237 b/tests/xfs/237
index 194cd0459..f172aaf59 100755
--- a/tests/xfs/237
+++ b/tests/xfs/237
@@ -60,7 +60,7 @@ md5sum $testdir/file2 | _filter_scratch
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
-sync
+_scratch_sync
 _dmerror_load_error_table
 $AIO_TEST -a $alignment -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
 _dmerror_load_working_table
diff --git a/tests/xfs/239 b/tests/xfs/239
index bfe722c0a..11a0d125a 100755
--- a/tests/xfs/239
+++ b/tests/xfs/239
@@ -56,7 +56,7 @@ md5sum $testdir/file2 | _filter_scratch
 
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
-sync
+_scratch_sync
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
 $AIO_TEST -a $alignment -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
 _scratch_cycle_mount
diff --git a/tests/xfs/240 b/tests/xfs/240
index 4f9311e8e..e95cf3f5d 100755
--- a/tests/xfs/240
+++ b/tests/xfs/240
@@ -62,7 +62,7 @@ md5sum $testdir/file2 | _filter_scratch
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
-sync
+_scratch_sync
 _dmerror_load_error_table
 $AIO_TEST -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -c "fdatasync" $testdir/file2
diff --git a/tests/xfs/241 b/tests/xfs/241
index 153249397..6d73d48e4 100755
--- a/tests/xfs/241
+++ b/tests/xfs/241
@@ -57,7 +57,7 @@ md5sum $testdir/file2 | _filter_scratch
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
-sync
+_scratch_sync
 $AIO_TEST -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
 _scratch_cycle_mount
 
diff --git a/tests/xfs/243 b/tests/xfs/243
index ea83a7b44..964e94e1d 100755
--- a/tests/xfs/243
+++ b/tests/xfs/243
@@ -66,7 +66,7 @@ seq 3 5 $nr | while read f; do
 	_pwrite_byte 0x71 $((blksz * f)) $blksz $testdir/file3 >> $seqres.full
 	_pwrite_byte 0x71 $((blksz * f)) $blksz $testdir/file3.chk >> $seqres.full
 done
-sync
+_scratch_sync
 # 4 blocks are delalloc (do later)
 seq 4 5 $nr | while read f; do
 	_pwrite_byte 0x62 $((blksz * f)) $blksz $testdir/file3 >> $seqres.full
@@ -102,7 +102,7 @@ echo "Regular data extents:"
 test $(_xfs_bmapx_find data $testdir/file3 -E '00[01]{4}$') -gt 0 || \
 	echo "Expected to find a regular data extent"
 
-sync
+_scratch_sync
 
 echo "Dump extents after sync"
 $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
diff --git a/tests/xfs/246 b/tests/xfs/246
index ce97fad5d..997a7ad47 100755
--- a/tests/xfs/246
+++ b/tests/xfs/246
@@ -25,7 +25,7 @@ mkdir $testdir
 
 echo "Create the original files"
 touch $testdir/file1
-sync
+_scratch_sync
 
 echo "Dump extents after sync"
 echo "Hole CoW extents:"
diff --git a/tests/xfs/265 b/tests/xfs/265
index 21de4c054..e7f939c14 100755
--- a/tests/xfs/265
+++ b/tests/xfs/265
@@ -44,7 +44,7 @@ for i in 1 2 x; do
 	seq 1 $nr_blks | while read nr; do
 		_cp_reflink $testdir/file1 $testdir/file1.$nr >> $seqres.full
 	done
-	sync
+	_scratch_sync
 
 	echo "$i: Truncate files"
 	seq 1 $nr_blks | while read nr; do
diff --git a/tests/xfs/272 b/tests/xfs/272
index b65e2fae5..3e3ceec51 100755
--- a/tests/xfs/272
+++ b/tests/xfs/272
@@ -33,7 +33,7 @@ _scratch_mount
 _xfs_force_bdev data $SCRATCH_MNT
 
 _pwrite_byte 0x80 0 737373 $SCRATCH_MNT/urk >> $seqres.full
-sync
+_scratch_sync
 $here/src/punch-alternating $SCRATCH_MNT/urk >> $seqres.full
 ino=$(stat -c '%i' $SCRATCH_MNT/urk)
 
diff --git a/tests/xfs/274 b/tests/xfs/274
index d06e7fc13..a6bdc7c03 100755
--- a/tests/xfs/274
+++ b/tests/xfs/274
@@ -32,7 +32,7 @@ _scratch_mkfs > "$seqres.full" 2>&1
 _scratch_mount
 
 _pwrite_byte 0x80 0 737373 $SCRATCH_MNT/f1 >> $seqres.full
-sync
+_scratch_sync
 $here/src/punch-alternating $SCRATCH_MNT/f1 >> $seqres.full
 _cp_reflink $SCRATCH_MNT/f1 $SCRATCH_MNT/f2
 ino=$(stat -c '%i' $SCRATCH_MNT/f1)
diff --git a/tests/xfs/276 b/tests/xfs/276
index f21f7a86e..69de69d86 100755
--- a/tests/xfs/276
+++ b/tests/xfs/276
@@ -37,7 +37,7 @@ _scratch_mount
 test $rtextsz -eq $dbsize || _notrun "Skipping test due to rtextsize > 1 fsb"
 
 $XFS_IO_PROG -f -R -c 'pwrite -S 0x80 0 737373' $SCRATCH_MNT/urk >> $seqres.full
-sync
+_scratch_sync
 $here/src/punch-alternating $SCRATCH_MNT/urk >> $seqres.full
 ino=$(stat -c '%i' $SCRATCH_MNT/urk)
 
diff --git a/tests/xfs/291 b/tests/xfs/291
index 0141c075b..777968a92 100755
--- a/tests/xfs/291
+++ b/tests/xfs/291
@@ -41,12 +41,12 @@ mkdir $SCRATCH_MNT/fragdir
 for I in `seq 0 26200`; do
         (echo data > $SCRATCH_MNT/fragdir/f$I) >> $seqres.full 2>&1
 done
-sync
+_scratch_sync
 
 for I in `seq 0 2 26200`; do
         rm -f $SCRATCH_MNT/fragdir/f$I >> $seqres.full 2>&1
 done
-sync
+_scratch_sync
 
 # Soak up any remaining freespace
 $XFS_IO_PROG -f -c "pwrite 0 16m" -c "fsync" $SCRATCH_MNT/space_file.large >> $seqres.full 2>&1
diff --git a/tests/xfs/309 b/tests/xfs/309
index 63ca0a67b..429a506c2 100755
--- a/tests/xfs/309
+++ b/tests/xfs/309
@@ -44,7 +44,7 @@ for i in 1 2 x; do
 	seq 1 $nr_blks | while read nr; do
 		_cp_reflink $testdir/file1 $testdir/file1.$nr >> $seqres.full
 	done
-	sync
+	_scratch_sync
 
 	echo "$i: Truncate files"
 	seq 1 $nr_blks | while read nr; do
diff --git a/tests/xfs/312 b/tests/xfs/312
index 6e47d442b..4c0fbf74a 100755
--- a/tests/xfs/312
+++ b/tests/xfs/312
@@ -45,7 +45,7 @@ _cp_reflink $SCRATCH_MNT/file1 $SCRATCH_MNT/file3
 seq 1 2 $blks | while read off; do
 	$XFS_IO_PROG -c "fpunch $((off * blksz)) $blksz" $SCRATCH_MNT/file3 >> $seqres.full
 done
-sync
+_scratch_sync
 
 echo "Check files"
 md5sum $SCRATCH_MNT/file1 | _filter_scratch
diff --git a/tests/xfs/313 b/tests/xfs/313
index d0c77db8b..8f533041b 100755
--- a/tests/xfs/313
+++ b/tests/xfs/313
@@ -44,7 +44,7 @@ _cp_reflink $SCRATCH_MNT/file1 $SCRATCH_MNT/file3
 seq 1 2 $blks | while read off; do
 	$XFS_IO_PROG -c "fpunch $((off * blksz)) $blksz" $SCRATCH_MNT/file3 >> $seqres.full
 done
-sync
+_scratch_sync
 
 echo "Check files"
 md5sum $SCRATCH_MNT/file1 | _filter_scratch
diff --git a/tests/xfs/314 b/tests/xfs/314
index 07596e00b..b86d06ae7 100755
--- a/tests/xfs/314
+++ b/tests/xfs/314
@@ -45,7 +45,7 @@ _cp_reflink $SCRATCH_MNT/file1 $SCRATCH_MNT/file3
 seq 1 2 $blks | while read off; do
 	$XFS_IO_PROG -c "fpunch $((off * blksz)) $blksz" $SCRATCH_MNT/file3 >> $seqres.full
 done
-sync
+_scratch_sync
 
 echo "Check files"
 md5sum $SCRATCH_MNT/file1 | _filter_scratch
diff --git a/tests/xfs/315 b/tests/xfs/315
index f6c346e18..af783a7ad 100755
--- a/tests/xfs/315
+++ b/tests/xfs/315
@@ -43,7 +43,7 @@ echo "Create files"
 _pwrite_byte 0x66 0 $sz $SCRATCH_MNT/file1 >> $seqres.full
 _pwrite_byte 0x66 $((sz / 2)) $((sz / 2)) $SCRATCH_MNT/file2 >> $seqres.full
 _reflink_range $SCRATCH_MNT/file1 0 $SCRATCH_MNT/file2 0 $((sz / 2)) >> $seqres.full
-sync
+_scratch_sync
 
 echo "Check files"
 md5sum $SCRATCH_MNT/file1 | _filter_scratch
@@ -54,7 +54,7 @@ _scratch_inject_error "free_extent"
 
 echo "CoW a few blocks"
 $XFS_IO_PROG -c "pwrite -W -S 0x67 -b $sz 0 $sz" $SCRATCH_MNT/file1 >> $seqres.full 2>&1
-sync
+_scratch_sync
 
 echo "FS should be shut down, touch will fail"
 touch $SCRATCH_MNT/badfs 2>&1 | _filter_scratch
diff --git a/tests/xfs/316 b/tests/xfs/316
index 63711ed47..3c92d1a1d 100755
--- a/tests/xfs/316
+++ b/tests/xfs/316
@@ -45,7 +45,7 @@ _cp_reflink $SCRATCH_MNT/file1 $SCRATCH_MNT/file3
 seq 1 2 $blks | while read off; do
 	$XFS_IO_PROG -c "fpunch $((off * blksz)) $blksz" $SCRATCH_MNT/file3 >> $seqres.full
 done
-sync
+_scratch_sync
 
 echo "Check files"
 md5sum $SCRATCH_MNT/file1 | _filter_scratch
diff --git a/tests/xfs/317 b/tests/xfs/317
index 192107f59..2ae0b903c 100755
--- a/tests/xfs/317
+++ b/tests/xfs/317
@@ -36,7 +36,7 @@ _scratch_mount >> $seqres.full
 echo "Create files"
 touch $SCRATCH_MNT/file1
 _pwrite_byte 0x67 0 $sz $SCRATCH_MNT/file0 >> $seqres.full
-sync
+_scratch_sync
 
 echo "Check files"
 md5sum $SCRATCH_MNT/file0 | _filter_scratch
diff --git a/tests/xfs/318 b/tests/xfs/318
index 590d268e6..4ff11be40 100755
--- a/tests/xfs/318
+++ b/tests/xfs/318
@@ -43,7 +43,7 @@ touch $SCRATCH_MNT/file1
 
 echo "Write files"
 $XFS_IO_PROG -c "pwrite -S 0x67 0 $sz" $SCRATCH_MNT/file1 >> $seqres.full
-sync
+_scratch_sync
 
 echo "Check files"
 md5sum $SCRATCH_MNT/file1 2>&1 | _filter_scratch
@@ -53,7 +53,7 @@ _scratch_inject_error "free_extent"
 
 echo "Remove files"
 rm -rf $SCRATCH_MNT/file1
-sync
+_scratch_sync
 $XFS_IO_PROG -x -c 'freeze' -c 'thaw' $SCRATCH_MNT >> $seqres.full 2>&1
 
 echo "FS should be shut down, touch will fail"
diff --git a/tests/xfs/319 b/tests/xfs/319
index 45b958d8f..66f191127 100755
--- a/tests/xfs/319
+++ b/tests/xfs/319
@@ -38,7 +38,7 @@ echo "Create files"
 _pwrite_byte 0x66 0 $sz $SCRATCH_MNT/file1 >> $seqres.full
 _cp_reflink $SCRATCH_MNT/file1 $SCRATCH_MNT/file2
 _pwrite_byte 0x67 0 $sz $SCRATCH_MNT/file3 >> $seqres.full
-sync
+_scratch_sync
 
 echo "Check files"
 md5sum $SCRATCH_MNT/file1 | _filter_scratch
diff --git a/tests/xfs/320 b/tests/xfs/320
index f7e4949a3..4cf174b88 100755
--- a/tests/xfs/320
+++ b/tests/xfs/320
@@ -37,7 +37,7 @@ _scratch_mount >> $seqres.full
 echo "Create files"
 _pwrite_byte 0x66 0 $sz $SCRATCH_MNT/file1 >> $seqres.full
 _cp_reflink $SCRATCH_MNT/file1 $SCRATCH_MNT/file2
-sync
+_scratch_sync
 
 echo "Check files"
 md5sum $SCRATCH_MNT/file1 | _filter_scratch
diff --git a/tests/xfs/321 b/tests/xfs/321
index a09e4a8ce..4ebde3e2a 100755
--- a/tests/xfs/321
+++ b/tests/xfs/321
@@ -37,7 +37,7 @@ _scratch_mount >> $seqres.full
 echo "Create files"
 _pwrite_byte 0x66 0 $sz $SCRATCH_MNT/file1 >> $seqres.full
 $XFS_IO_PROG -f -c "truncate $sz" $SCRATCH_MNT/file3 >> $seqres.full
-sync
+_scratch_sync
 
 echo "Check files"
 md5sum $SCRATCH_MNT/file1 | _filter_scratch
diff --git a/tests/xfs/322 b/tests/xfs/322
index 4cb36a515..0492b647e 100755
--- a/tests/xfs/322
+++ b/tests/xfs/322
@@ -39,7 +39,7 @@ _require_congruent_file_oplen $SCRATCH_MNT $blksz
 echo "Create files"
 _pwrite_byte 0x66 0 $sz $SCRATCH_MNT/file1 >> $seqres.full
 $XFS_IO_PROG -f -c "truncate $sz" $SCRATCH_MNT/file3 >> $seqres.full
-sync
+_scratch_sync
 
 echo "Check files"
 md5sum $SCRATCH_MNT/file1 | _filter_scratch
diff --git a/tests/xfs/323 b/tests/xfs/323
index 0579d4a72..ee45ba608 100755
--- a/tests/xfs/323
+++ b/tests/xfs/323
@@ -37,7 +37,7 @@ _scratch_mount >> $seqres.full
 echo "Create files"
 _pwrite_byte 0x66 0 $sz $SCRATCH_MNT/file1 >> $seqres.full
 _pwrite_byte 0x67 0 $sz $SCRATCH_MNT/file3 >> $seqres.full
-sync
+_scratch_sync
 
 echo "Check files"
 md5sum $SCRATCH_MNT/file1 | _filter_scratch
diff --git a/tests/xfs/324 b/tests/xfs/324
index 485b16215..b86bb0ea8 100755
--- a/tests/xfs/324
+++ b/tests/xfs/324
@@ -45,7 +45,7 @@ _cp_reflink $SCRATCH_MNT/file1 $SCRATCH_MNT/file3
 seq 1 2 $blks | while read off; do
 	$XFS_IO_PROG -c "fpunch $((off * blksz)) $blksz" $SCRATCH_MNT/file3 >> $seqres.full
 done
-sync
+_scratch_sync
 
 echo "Check files"
 md5sum $SCRATCH_MNT/file1 | _filter_scratch
diff --git a/tests/xfs/325 b/tests/xfs/325
index 2387b8d88..f06eda64e 100755
--- a/tests/xfs/325
+++ b/tests/xfs/325
@@ -39,7 +39,7 @@ _scratch_mount >> $seqres.full
 echo "Create files"
 _pwrite_byte 0x66 0 $((blksz * blks)) $SCRATCH_MNT/file1 >> $seqres.full
 _cp_reflink $SCRATCH_MNT/file1 $SCRATCH_MNT/file2
-sync
+_scratch_sync
 
 echo "Check files"
 md5sum $SCRATCH_MNT/file1 | _filter_scratch
@@ -52,7 +52,7 @@ echo "Inject error"
 _scratch_inject_error "free_extent"
 
 rm $SCRATCH_MNT/file1
-sync
+_scratch_sync
 $XFS_IO_PROG -x -c 'freeze' -c 'thaw' $SCRATCH_MNT >> $seqres.full 2>&1
 
 echo "FS should be shut down, touch will fail"
diff --git a/tests/xfs/326 b/tests/xfs/326
index 5d7afe9bf..a06879c3e 100755
--- a/tests/xfs/326
+++ b/tests/xfs/326
@@ -62,7 +62,7 @@ _cp_reflink $SCRATCH_MNT/file1 $SCRATCH_MNT/file3
 seq 1 2 $blks | while read off; do
 	$XFS_IO_PROG -c "fpunch $((off * blksz)) $blksz" $SCRATCH_MNT/file3 >> $seqres.full
 done
-sync
+_scratch_sync
 
 echo "Check files"
 md5sum $SCRATCH_MNT/file1 | _filter_scratch
@@ -70,7 +70,7 @@ md5sum $SCRATCH_MNT/file2 | _filter_scratch
 md5sum $SCRATCH_MNT/file3 | _filter_scratch
 
 $XFS_IO_PROG -c "pwrite -W -S 0x67 $((10 * blksz)) 1" $SCRATCH_MNT/file2 >> $seqres.full
-sync
+_scratch_sync
 
 echo "Inject error"
 _scratch_inject_error "refcount_finish_one"
diff --git a/tests/xfs/327 b/tests/xfs/327
index 44728c117..1f2ee5484 100755
--- a/tests/xfs/327
+++ b/tests/xfs/327
@@ -37,7 +37,7 @@ _pwrite_byte 0x66 0 1 $SCRATCH_MNT/file.0 >> $seqres.full
 seq 1 $nr | while read i; do
 	_cp_reflink $SCRATCH_MNT/file.0 $SCRATCH_MNT/file.$i
 done
-sync
+_scratch_sync
 
 ino_0=$(stat -c '%i' $SCRATCH_MNT/file.0)
 ino_64=$(stat -c '%i' $SCRATCH_MNT/file.64)
diff --git a/tests/xfs/420 b/tests/xfs/420
index 038682ef9..37fb8c6b8 100755
--- a/tests/xfs/420
+++ b/tests/xfs/420
@@ -109,7 +109,7 @@ md5sum $testdir/file3 | _filter_scratch
 echo 1 > /proc/sys/vm/drop_caches
 
 echo "sync filesystem" | tee -a $seqres.full
-sync
+_scratch_sync
 
 $XFS_IO_PROG -c "bmap -ev" -c "bmap -cv" $testdir/file1 >> $seqres.full 2>&1
 $XFS_IO_PROG -c "bmap -ev" -c "bmap -cv" $testdir/file2 >> $seqres.full 2>&1
diff --git a/tests/xfs/421 b/tests/xfs/421
index ab565e1f6..fdee45ce4 100755
--- a/tests/xfs/421
+++ b/tests/xfs/421
@@ -94,7 +94,7 @@ md5sum $testdir/file3 | _filter_scratch
 echo 1 > /proc/sys/vm/drop_caches
 
 echo "sync filesystem" | tee -a $seqres.full
-sync
+_scratch_sync
 
 $XFS_IO_PROG -c "bmap -ev" -c "bmap -cv" $testdir/file1 >> $seqres.full 2>&1
 $XFS_IO_PROG -c "bmap -ev" -c "bmap -cv" $testdir/file2 >> $seqres.full 2>&1
diff --git a/tests/xfs/423 b/tests/xfs/423
index 1fbf500d8..78fd91301 100755
--- a/tests/xfs/423
+++ b/tests/xfs/423
@@ -31,7 +31,7 @@ _scratch_mount
 $XFS_IO_PROG -f -c 'falloc 0 10m' $SCRATCH_MNT/a >> $seqres.full
 $XFS_IO_PROG -f -c 'falloc 0 10m' $SCRATCH_MNT/b >> $seqres.full
 $here/src/punch-alternating $SCRATCH_MNT/b
-sync
+_scratch_sync
 
 echo "Set up delalloc extents"
 $XFS_IO_PROG -c 'pwrite -S 0x66 10m 128k' $SCRATCH_MNT/a >> $seqres.full
diff --git a/tests/xfs/438 b/tests/xfs/438
index 0239778c5..6d1988c8b 100755
--- a/tests/xfs/438
+++ b/tests/xfs/438
@@ -136,7 +136,7 @@ $DMSETUP_PROG table >> $seqres.full
 $XFS_QUOTA_PROG -x -c "limit -u isoft=400 $qa_user" $SCRATCH_MNT
 $XFS_QUOTA_PROG -x -c "report -ih" $SCRATCH_MNT >> $seqres.full
 
-sync
+_scratch_sync
 
 # wait for the push of the dquota log item in AIL and
 # the completion of the retried write of dquota buffer
diff --git a/tests/xfs/440 b/tests/xfs/440
index fc7319449..0cc679aeb 100755
--- a/tests/xfs/440
+++ b/tests/xfs/440
@@ -43,7 +43,7 @@ $XFS_IO_PROG -c 'stat -r' $SCRATCH_MNT/a | grep stat.size >> $seqres.full
 _report_quota_blocks "-u $SCRATCH_MNT"
 
 echo "Sync"
-sync
+_scratch_sync
 _report_quota_blocks "-u $SCRATCH_MNT"
 
 echo "Chown and check quota"
diff --git a/tests/xfs/442 b/tests/xfs/442
index 5cbd8dd19..58e56b5d2 100755
--- a/tests/xfs/442
+++ b/tests/xfs/442
@@ -36,7 +36,7 @@ compare_quota_to_du() {
 # This ensures that we did the quota accounting correctly and that we're
 # accurately reporting cow preallocation blocks in stat.
 check_quota_du_blocks() {
-	sync
+	_scratch_sync
 	#$XFS_QUOTA_PROG -x -c 'report' $SCRATCH_MNT >> $seqres.full
 	du_rep=$(du -ks $SCRATCH_MNT | awk '{print $1}')
 	u_rep=$(report_quota_blocks -u)
diff --git a/tests/xfs/511 b/tests/xfs/511
index b55c34b92..a942e92e3 100755
--- a/tests/xfs/511
+++ b/tests/xfs/511
@@ -33,7 +33,7 @@ _require_prjquota $SCRATCH_DEV
 
 # Create a directory to be project object, and create a file to take 64k space
 mkdir $SCRATCH_MNT/t
-$XFS_IO_PROG -f -c "pwrite 0 65536" -c sync $SCRATCH_MNT/t/file >>$seqres.full
+$XFS_IO_PROG -f -c "pwrite 0 65536" -c syncfs $SCRATCH_MNT/t/file >>$seqres.full
 
 quota_cmd="$XFS_QUOTA_PROG -x"
 $quota_cmd -c "project -s -p $SCRATCH_MNT/t 42" $SCRATCH_MNT >/dev/null 2>&1
diff --git a/tests/xfs/519 b/tests/xfs/519
index ac815f123..37a139c9e 100755
--- a/tests/xfs/519
+++ b/tests/xfs/519
@@ -28,7 +28,7 @@ $XFS_IO_PROG -f -c 'pwrite -S 0x59 0 1m -b 1m' $SCRATCH_MNT/c >> $seqres.full
 _cp_reflink $SCRATCH_MNT/a $SCRATCH_MNT/e
 _cp_reflink $SCRATCH_MNT/c $SCRATCH_MNT/d
 touch $SCRATCH_MNT/b
-sync
+_scratch_sync
 
 # Test that setting the reflink flag on the dest file forces the log
 echo "test reflink flag not set"
diff --git a/tests/xfs/520 b/tests/xfs/520
index 3734d8746..2d80188b2 100755
--- a/tests/xfs/520
+++ b/tests/xfs/520
@@ -46,7 +46,7 @@ force_crafted_metadata() {
 	if [ $mounted -ne 0 ]; then
 		dd if=/dev/zero of=$SCRATCH_MNT/test bs=65536 count=1 >> \
 			$seqres.full 2>&1
-		sync
+		_scratch_sync
 	fi
 
 	_dmesg_since_test_start | tac | sed -ne "0,\#${kmsg}#p" | tac | \
diff --git a/tests/xfs/541 b/tests/xfs/541
index 518373fa8..9be15d1f6 100755
--- a/tests/xfs/541
+++ b/tests/xfs/541
@@ -91,7 +91,7 @@ test $after_rtextsz_blocks -eq $new_rtextsz_blocks || \
 
 # Create a new realtime file to prove that we can.
 echo moo > $SCRATCH_MNT/a
-sync -f $SCRATCH_MNT
+_scratch_sync
 $XFS_IO_PROG -c 'lsattr -v' $SCRATCH_MNT/a | \
 	cut -d ' ' -f 1 | \
 	grep -q realtime || \
diff --git a/tests/xfs/553 b/tests/xfs/553
index f4294e9c1..13ef629e3 100755
--- a/tests/xfs/553
+++ b/tests/xfs/553
@@ -45,7 +45,7 @@ $XFS_IO_PROG -c "cowextsize $((blksz * 4096))" $destination >> $seqres.full
 echo "Fragment FS"
 $XFS_IO_PROG -f -c "pwrite 0 $((blksz * 16384))" $fragmented_file \
 	     >> $seqres.full
-sync
+_scratch_sync
 $here/src/punch-alternating $fragmented_file >> $seqres.full
 
 echo "Inject bmap_alloc_minlen_extent error tag"
@@ -54,7 +54,7 @@ _scratch_inject_error bmap_alloc_minlen_extent 1
 echo "Create delalloc extent of length 4096 blocks in destination file's CoW fork"
 $XFS_IO_PROG -c "pwrite 0 $blksz" $destination >> $seqres.full
 
-sync
+_scratch_sync
 
 echo "Direct I/O write at 3rd block in destination file"
 $XFS_IO_PROG -d -c "pwrite $((blksz * 3)) $((blksz * 2))" $destination \
diff --git a/tests/xfs/558 b/tests/xfs/558
index ec2fbcb68..ba137ae8d 100755
--- a/tests/xfs/558
+++ b/tests/xfs/558
@@ -140,13 +140,13 @@ $XFS_IO_PROG -c 'cowextsize 1m' $SCRATCH_MNT
 # Write out a file with the first two blocks unshared and the rest shared.
 _pwrite_byte 0x59 0 $((160 * blksz)) $SCRATCH_MNT/file >> $seqres.full
 _pwrite_byte 0x59 0 $((160 * blksz)) $SCRATCH_MNT/file.compare >> $seqres.full
-sync
+_scratch_sync
 
 _cp_reflink $SCRATCH_MNT/file $SCRATCH_MNT/file.reflink
 
 _pwrite_byte 0x58 0 $((2 * blksz)) $SCRATCH_MNT/file >> $seqres.full
 _pwrite_byte 0x58 0 $((2 * blksz)) $SCRATCH_MNT/file.compare >> $seqres.full
-sync
+_scratch_sync
 
 # Avoid creation of large folios on newer kernels by cycling the mount and
 # immediately writing to the page cache.
@@ -156,7 +156,7 @@ _scratch_cycle_mount
 # before slowing down writeback to avoid unnecessary delay.
 _pwrite_byte 0x57 0 $((2 * blksz)) $SCRATCH_MNT/file.compare >> $seqres.full
 _pwrite_byte 0x56 $((2 * blksz)) $((2 * blksz)) $SCRATCH_MNT/file.compare >> $seqres.full
-sync
+_scratch_sync
 
 # Introduce a half-second wait to each writeback block mapping call.  This
 # gives us a chance to race speculative cow prealloc with writeback.
diff --git a/tests/xfs/607 b/tests/xfs/607
index 530fea9ed..ae1e19a9a 100755
--- a/tests/xfs/607
+++ b/tests/xfs/607
@@ -53,7 +53,7 @@ fi
 echo "Create source file"
 $XFS_IO_PROG -f -c "pwrite 0 $((blksz * 256))" $file1 >> $seqres.full
 
-sync
+_test_sync
 
 echo "Create Reflinked file"
 _cp_reflink $file1 $file2 >> $seqres.full
@@ -63,7 +63,7 @@ $XFS_IO_PROG -c "cowextsize $((blksz * 128))" -c stat $file1 >> $seqres.full
 
 echo "Fragment FS"
 $XFS_IO_PROG -f -c "pwrite 0 $((blksz * 512))" $fragmentedfile >> $seqres.full
-sync
+_test_sync
 $here/src/punch-alternating $fragmentedfile
 
 echo "Allocate block sized extent from now onwards"
@@ -72,7 +72,7 @@ _test_inject_error bmap_alloc_minlen_extent 1
 echo "Create big delalloc extent in CoW fork"
 $XFS_IO_PROG -c "pwrite 0 $blksz" $file1 >> $seqres.full
 
-sync
+_test_sync
 
 $XFS_IO_PROG -c 'bmap -elpv' -c 'bmap -celpv' $file1 &>> $seqres.full
 
diff --git a/tests/xfs/617 b/tests/xfs/617
index 2f5bf5233..e0ad7d816 100755
--- a/tests/xfs/617
+++ b/tests/xfs/617
@@ -35,7 +35,7 @@ swap_and_check_contents() {
 	local b="$2"
 	local tag="$3"
 
-	sync
+	_scratch_sync
 
 	# Test exchangerange.  -w means skip holes in /b
 	echo "swap $tag" >> $seqres.full
diff --git a/tests/xfs/629 b/tests/xfs/629
index 58beedc03..34b3ca0d6 100755
--- a/tests/xfs/629
+++ b/tests/xfs/629
@@ -55,7 +55,7 @@ for ((n=0; n<nfiles; n++)); do
 	write_sync_file $n > /dev/null 2>&1 &
 done
 wait
-sync
+_scratch_sync
 
 for ((n=0; n<nfiles; n++)); do
 	count=$(_count_extents $workfile.$n)
diff --git a/tests/xfs/630 b/tests/xfs/630
index 939d8a4ac..79dcb44bc 100755
--- a/tests/xfs/630
+++ b/tests/xfs/630
@@ -58,7 +58,7 @@ for ((n=0; n<nfiles; n++)); do
 	write_extsz_file $n > /dev/null 2>&1 &
 done
 wait
-sync
+_scratch_sync
 
 for ((n=0; n<nfiles; n++)); do
 	count=$(_count_extents $workfile.$n)
diff --git a/tests/xfs/631 b/tests/xfs/631
index 55a742979..4d79b821f 100755
--- a/tests/xfs/631
+++ b/tests/xfs/631
@@ -58,7 +58,7 @@ for ((n=0; n<nfiles; n++)); do
 	write_direct_file $n > /dev/null 2>&1 &
 done
 wait
-sync
+_scratch_sync
 
 for ((n=0; n<nfiles; n++)); do
 	count=$(_count_extents $workfile.$n)
diff --git a/tests/xfs/790 b/tests/xfs/790
index 53e8906bb..d0bdaef96 100755
--- a/tests/xfs/790
+++ b/tests/xfs/790
@@ -45,7 +45,7 @@ $here/src/punch-alternating $dir/a
 _pwrite_byte 0x59 0 $((blksz * nrblks)) $dir/b >> $seqres.full
 _pwrite_byte 0x59 0 $((blksz * nrblks)) $dir/c >> $seqres.full
 _pwrite_byte 0x58 0 $((blksz * nrblks)) $dir/a >> $seqres.full
-sync
+_test_sync
 
 # Inject a bmap error and trigger it via exchangerange.
 filesnap "before commit"
diff --git a/tests/xfs/791 b/tests/xfs/791
index bca580420..0fcc48190 100755
--- a/tests/xfs/791
+++ b/tests/xfs/791
@@ -38,7 +38,7 @@ _pwrite_byte 0x58 0 1m $SCRATCH_MNT/a >> $seqres.full
 $XFS_IO_PROG -f -c 'truncate 1m' $SCRATCH_MNT/b
 _pwrite_byte 0x59 64k 64k $SCRATCH_MNT/b >> $seqres.full
 _pwrite_byte 0x57 768k 64k $SCRATCH_MNT/b >> $seqres.full
-sync
+_scratch_sync
 
 md5sum $SCRATCH_MNT/a | _filter_scratch
 md5sum $SCRATCH_MNT/b | _filter_scratch
diff --git a/tests/xfs/792 b/tests/xfs/792
index cdfa63692..6c7b2db11 100755
--- a/tests/xfs/792
+++ b/tests/xfs/792
@@ -33,7 +33,7 @@ _scratch_mount
 
 # Create original file
 _pwrite_byte 0x58 0 1m $SCRATCH_MNT/a >> $seqres.full
-sync
+_scratch_sync
 md5sum $SCRATCH_MNT/a | _filter_scratch
 
 # Test atomic scatter-gather file commits.
-- 
2.45.2

