Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31759450
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683250; cv=none; b=Jkdj1gkRCe9Le0p7GtI3Hj17RfVoEkguEO1h6uBJ+DlJ9heT2kF4ohPNr49kJgpJ7cggFhUGp4nQGccJe2NtodUC25AmQWX7ZiORjRyJyy7ajOaAOCZ84ah/iIu91kG8CDDMpgLkvzLeWBttIY/1f9oS2qTp0R7RhHUgSZRVw4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683250; c=relaxed/simple;
	bh=X7p3I2aHwuiVgGyGN04fkwzDteLgOvI9SR2LOGUklWw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOWXo76UbRI6YkkCsyXC1ZdrLpHdtEai55waSsn8s6HSpzrdxe1I8g1nTo1akiKaUXp2Ugu9fohUerPiZVET1E7jO+3vYxZDEa8K/BlOYY31EspWzj6bgnUjVCqvNEtC1710Osi4yXlt2XyLxdD1/3YMQtrGEB1IPxjlsORq2sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=oaOFi2eF; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="oaOFi2eF"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so5212956a12.3
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683248; x=1733288048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nw/JbaFyOQ36Z7Twm3eM/DwgLcrXScvc9zCjUac6R2c=;
        b=oaOFi2eF5GQkYqa08nokNsrlvgloBAWpTGhB+3cZE9A6+ffFt5yGH3B3VmomN2pWwC
         bZMI9jhlEbEjRRO9LcxHOGW1zDb9T7kzgfQPTG0AhBJjH4X5FAz/bFrOpcfb/cCZxv9K
         /CTWBIHcYygfwMdsSXUMUektuBTSXdDj7A3J8D2GP1lxKbkgQcQaWoTTXs0ICY8N1XeO
         ANJbRUvfc++vwrBfhMWQJ1Qv7OD/crBRdIe6LufZWCXaddRjUm6Xc5q+0OKPrGo3mnRT
         fWIOzrFEFsLx6A04xXGl/t7zySXU0EqmJU0bqW8AXrh8c/9Y6+7jeYBco/6XvsriRose
         AtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683248; x=1733288048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nw/JbaFyOQ36Z7Twm3eM/DwgLcrXScvc9zCjUac6R2c=;
        b=O0fe1KlJimYLCUBWhHFX6WQkqE5QKNzXaViopRmdCEbRZB5IJvRd3qSNE9PTLxyRXe
         VsD88cDhKbxuTVjQOLfnPg8GqmaEvZyw13wt7Ml9uTwg7ZLOp90cdd4ghwTUxoupRCzE
         aPRUa7ld+xSc6tAZiXK6tgotuO5uAMYEY8f5/LAIV4zFkIXtzWacuFVPG7nTA1u3ivD/
         eBm7jQ7WrR+YROaJUsIIbFfs0pgTO/QjB2UZSpU+IZC6PFn2RPwEW9ErsguvQs7ohJ5O
         cgcltBtT+5Vg1yFwIsoayvi99B+HAMWQBARL6Xpbs2jeW0OLJMID+VPlWHBdy1v4cgpZ
         bt2A==
X-Gm-Message-State: AOJu0YwMm5vHAlyjuWf3NIjpp2ABmpKAusLIcexc9j4wkYen3aNq/8cp
	MVLuphX1w9vI+wqwIAa9iD3qDU9HxecqZUFcglo9emvXRZd33EzZV0GNTaPjBprD6ITghTfMtDo
	Y
X-Gm-Gg: ASbGncsNWrwZodW25z35KKy63rrja4XQyzbORagjQJaB/++iNG8Zwq2EVynk4tbO1Hw
	Iw+l+RD3gwNZ7CxYApHKS8sLneXyrefJnMn2WC9NPL94FNdlqC/cX0BcSmflYvLMLH+V/bFyAOt
	nAKA8HOpyslpb5otxBOGjh0eP0YKYdK8gWmOoEekYT4RUybZNpGJQsGdEV34O5jrwZavKDa2R5M
	BS1ox8bqwi5Da9btiBUMVv+AIx0+0InLKhl9s10PgT0P4BeQ8n23meYUDyFZnUy796003mArSWO
	8kMpqV29iZs64aeDwUJXVkU3
X-Google-Smtp-Source: AGHT+IGTWw4FbN1JQuEGO2BNM0MwBbNFtkZ3/1hkvId9VARq7AOL6GfW8lWdJmuaixBntrLnPh/xGw==
X-Received: by 2002:a05:6a21:4610:b0:1db:e5ac:3d5b with SMTP id adf61e73a8af0-1e0e0b8cc45mr2570924637.39.1732683248024;
        Tue, 26 Nov 2024 20:54:08 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc2024asm93523495ad.224.2024.11.26.20.54.07
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:54:07 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3w-00000003ZTs-2k3w
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:04 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3w-0000000FQdW-3GQv
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:04 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 01/40] xfs/448: get rid of assert-on-failure
Date: Wed, 27 Nov 2024 15:51:31 +1100
Message-ID: <20241127045403.3665299-2-david@fromorbit.com>
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

The bug this problem exercises has been fixed for quite some time,
but the test does not run on XFS debug kernels that have fatal
asserts enable. There is no reason for this now that the test does
not assert fail on most kernels regularly tested, so kill the
check and enable the test to run on all XFS configs.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/448 | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tests/xfs/448 b/tests/xfs/448
index fbd1af383..032c94d39 100755
--- a/tests/xfs/448
+++ b/tests/xfs/448
@@ -13,10 +13,6 @@
 # up the directory tree by running xfs_scrub will crash the
 # kernel in __xfs_dir3_data_check.
 #
-# Notice:
-# we should have non fatal asserts configured, because assert
-# failures triggered by the intentional corrupt would crash system.
-#
 . ./common/preamble
 _begin_fstest auto quick fuzzers
 
@@ -26,8 +22,6 @@ _begin_fstest auto quick fuzzers
 
 _require_scratch_nocheck
 _require_xfs_io_command "scrub"
-# Corrupt XFS on purpose, and skip if assert failures would crash system.
-_require_no_xfs_bug_on_assert
 
 rm -f "$seqres.full"
 
-- 
2.45.2

