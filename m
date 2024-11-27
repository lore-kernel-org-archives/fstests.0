Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2344689
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683599; cv=none; b=aamhRZsYFtzleIA9CM7vQ9x5E/WT2uHfVuDn22Yw+cuW9a/8UAcymh07cm4FazkOwiXnDLowHSWVgcGUw6Lu8GTcRrYapmOAqpKwWkDUXLMZedZmNP9Jm9W/WK3e+TLe3xrGPOAl/SDGHni1xiOQiggNh3VV+PQZqQMymzlftis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683599; c=relaxed/simple;
	bh=Rnjevz6/P2vRV4yIlfNJs0Wj4xrAQdh4gXrfKgTACmE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBTl1NTfOVaHi4pwA3UJnkumIWQBqdH4GaslpTbuCRjnitIZnDw6E3qZ5VR5HnhF/+njXKzvtqWl3xE62rjxKDxq1X09NN71bH2WzO4OEg4hw/x1TYQaZV7LYJ1N0cyzZ25DYqaEqUE7L6qFnXE8wKsmRxc0GJEil8/KFqZRPNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=CIyF3Du9; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="CIyF3Du9"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea9739647bso5020093a12.0
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683597; x=1733288397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utZlEfz+5dQ67HxxRHCS5IF8SSWsM/ZWS2gS45Zg7cI=;
        b=CIyF3Du9t409bdKkEsrtN473xhcmy84ejMGkw4zL6Bb0338ABIy4nkieHIiZPVjfpg
         zrvOtotFLRIworvZszPWn76uIHvHotDQGe+VeLzUbL5YOntH39l8DbVx3XbNlqdz2duv
         bJrdvOmAEDcHKzWzuK+NYxQZuxS7knrwyMdIC/17gpPJ7RurSOYuyUKZ8nn2zzfVKXVR
         Vu4EDf+2ZfPUO1dPvJY+ZghYBErGQiCWV/Kb/3RyTfWXw4JwJei4UJ+/SD7fyjvsPocp
         zVdCWpbUZH0RtA0a3QEIkpogjvr6s6T39x+Le8HGQdrP0Iobbyj1pmnkUPovpNHrTq+p
         lngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683597; x=1733288397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utZlEfz+5dQ67HxxRHCS5IF8SSWsM/ZWS2gS45Zg7cI=;
        b=oqG0nVIcDXr8N2kORoJw9jodosuVNwPVog0cC9QfuN2/3xHbZUkQSRvbtTWRj2zDq9
         oP7lOzC1DidNbFaR7GeAIMvxc8O4VUbefntY9/xRhg9J2viyvYP0RP1WPC625Nf/7Hx+
         +PUMy9lCjIEOaSnpWkcHtc8vYI4K3hPdCPvODkj8jI3pOO/i7A4awcIkDg9kbrGC2g33
         uK975Z0qGAY80Lv884VdH8V7W9mIbrA0yKeplT5JLnOu7D7jbvbmNxKfX9m9wOfk+lId
         V4WZGwVP8ge6S6Kqay4Zy96GgenFQsMRmFurhQTE+t0JQj6Av5PH8FmLEnIphVlnK56e
         6bKw==
X-Gm-Message-State: AOJu0YyP/inqKi6blsc3SA6uexDQJ6uqO1mHnFJfxlJkCBAlFHIrk9vW
	qm/sRofvwdX4iiNOGlFS7eCSjoUT/NSvyqYz/0Er3AvzToJb+8SL+pUj8SFV4RNJmQqXT8wWzY2
	J
X-Gm-Gg: ASbGncse8poTT+fbvWiB3i72WO/mQBsh/2ZVyjheelGtJMqwEkKJceDuJZ/NOqKxQdZ
	X5mLRvZEH8kAk/uc6lyFMoi2SFWRnXkeQpXCcEiLZDauyaz4AIHvwBxuwW8UIuJ4IdC3ZpPrCBc
	qmIbweaoymlk0E74xom5eeIEqN/2YEFi4sHY9eG3Nxg7vyDGewMrt7lgrM0VVb8y9l2UfFJ4q11
	s+QSDbvAhxicCsO9/NGyFx7k9p1aQVdynISlkaNUDLF4R9mE1RT4i9NItPtA5L54B7Xh9mS333Z
	k7HO2iojkCwF/w==
X-Google-Smtp-Source: AGHT+IHR+N4uic1Lb69P9ZtgkuukxcvYP7eh1kQbKbYK5vIWYH12vB9CzvJS8LRp/0CN+6SYZKyjSA==
X-Received: by 2002:a05:6a20:3944:b0:1d8:a13d:d6b2 with SMTP id adf61e73a8af0-1e0e0ac2cdbmr3093537637.10.1732683597233;
        Tue, 26 Nov 2024 20:59:57 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de531b5bsm9272346b3a.99.2024.11.26.20.59.56
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:59:56 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZUv-1Wa7
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQep-257J
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 17/40] xfs/442: rescale load so it's not exponential
Date: Wed, 27 Nov 2024 15:51:47 +1100
Message-ID: <20241127045403.3665299-18-david@fromorbit.com>
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

....
xfs/442 491
....

xfs/442 takes a long time to run because it is scaling the load
by the number of processes it is going to run on twice. It scales
the number of operations by the number of processes it is going to
run, meaning that doubling the number of processes quadruples the
runtime.

Reduce it to scale linearly by fixing the number of ops it runs per
process.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/442 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/442 b/tests/xfs/442
index 58e56b5d2..d539fa5e0 100755
--- a/tests/xfs/442
+++ b/tests/xfs/442
@@ -63,7 +63,7 @@ _scratch_mkfs_sized $((1600 * 1048576)) > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
 nr_cpus=$((LOAD_FACTOR * 4))
-nr_ops=$((25000 * nr_cpus * TIME_FACTOR))
+nr_ops=$((25000 * TIME_FACTOR))
 _run_fsstress -w -d $SCRATCH_MNT -n $nr_ops -p $nr_cpus
 
 echo "Check quota before remount"
-- 
2.45.2

