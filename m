Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A81AF0D0
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744859540; cv=none; b=lNyRcvG0CNlbBA66GFO/k5PzTY/jMnf9w3zvJXqj3NCLW7BlXQ2AdrbL/2NvfGqE2XjKYWwbOkm+qaWNBsZGmzIlDDPdkkISPMJ1RJn6uuxyW53dDzp4svJZLzWKlvcv1NJ1BGdl01Pyd32lc2aTki4uKZPCLRssnasrAid/q2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744859540; c=relaxed/simple;
	bh=mlcsOok4NoyB+pvtzK/+5PawQXwbju1R1VESbKChQuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7CwDVKvTBVE3tgW/ywWZ+lDqN+8TX5gQs7Ocme0DVXhcrcYt3TuVm0fZeDvNELxns6P9S8+JJ2Q4FjVoZKFQgTuOOssx4EXhUIkXDJdJ2n2a4GRgnjyCLQwAr2YQa/LgpgexEyrQLSkQEgug7j6QRTyg+MeLiUyrXS9X/NEjOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Eika2LP9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Eika2LP9"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22435603572so3391085ad.1
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744859536; x=1745464336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPuCmJPWCkM4HgfFyjIA9cmRQITXxMfROdU74tsrtD4=;
        b=Eika2LP9qC5epoqOjKisSDpawsFAaKtuIgo1ZCg8uLJKAAgf1KBFAFz/xbsbUy5i9z
         sr7XFSBcQwBTlep3Ln9dWyyN1LbYZAkXmQQrmfU0jfWR4YYxPlpIuEHU+WTnpOrqdZoU
         JSJqgtOsgsuDvEBhw8caVD1aIBUTIkscfJxEWYPLrNx6GH0Lg9k6LEEP+L1xalo5S0c0
         QBm/QzFNUTgsdifK3nEq9akcDl6T+nHHormCiTTJMOCS3PSAVDnnkyCv27oopJDsBwDq
         6sV8+hDMGuONiKJWChMH64RM1XhRiMuX/5p9IQu/j5qShAawf4ZM6cTuu7Di/WJVBwYx
         dBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744859536; x=1745464336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPuCmJPWCkM4HgfFyjIA9cmRQITXxMfROdU74tsrtD4=;
        b=e6zhhjUz9QNH9TWciBCLhgZbI1iijnprexiBeUVpL7zQmTWLgbF4xVX8H7Hyx4VwtG
         RO9sOF1bfpkNVp6Z7pPoiOryh8k21byYSCZllLomDFVAKSExlUXyK0AcAS9+MIwjdmu/
         Scn71yKttPtxNBRxC4Z6DiRKD5rt7d2sRS8tCiMAWJBhO+BijfrQCpSoX1Im9g/wLEj7
         YDEea+baxek54w+6PQizJaaIcSrG98e4cPK6czUPkvExlhua6RmoVotsk27gkeIH/hwi
         Yr7nu2oW1/Hb0B//NZGCam5CCtUIVxdIa8jMtuEeZCEUG4RfggX3ZbbJdW7ddqqiQX3U
         LliA==
X-Gm-Message-State: AOJu0YxlH7tFpljJMORIFeGF74nbpTN9I3kEcSrfBqOzLfxTH0lA49GH
	brUwcACz/EZpOeV9Hz2JjtH25y6e93tdI6o/S8oBZ/NY9IObZzJ+ek/vAqCwlIRRDIb6/4LwJYF
	P
X-Gm-Gg: ASbGncvGCMvRW8mwvxuTj6NHFoDqp/C3nygF0PsJTVhbZRTqpqCv+RhPsZpjC/z/yed
	/XvCOb4aPVCYBR1lKKUiD+WElgSkiZgysbm3mwffZ9ho703zq5DyGpYFh04yD7XCYCxy0RrEU5t
	FXTijKNsSVJpn/SUvzaC09ipvEcrz/JawhS4GcAZS7ltQ/xx8VrNGe76uaqe9a+z/lex10XCdZ6
	KyqEIqPQvogddhGh+ostt0lrT8KOgtaw9HFBvwjUuK9KW1aXbnZQWc4llHDzskXoLauUgCJsJdp
	NXuK0EdIYPTpNPLaMIeQjYmvjf2gFd4f9KWk7l44ffJPdKrCZElLuW4Z2W2bLqQH/bQQaNMK/r/
	nNetW6CZ9EQD1
X-Google-Smtp-Source: AGHT+IHK2DVqvl66uJJyUFQOSb8ArOOnhkzXmIGSndwvpjAjd1EVLTO0LcCg+Rj4pkOGFMEOpY6+kQ==
X-Received: by 2002:a17:902:d4c1:b0:223:4816:3e9e with SMTP id d9443c01a7336-22c358d7039mr52460135ad.13.1744859536489;
        Wed, 16 Apr 2025 20:12:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f883asm11585420b3a.107.2025.04.16.20.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:12:13 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009YAT-1yMl;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mFJ-2sIu;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 18/28] check-parallel: create a "results-latest" symlink
Date: Thu, 17 Apr 2025 13:00:59 +1000
Message-ID: <20250417031208.1852171-19-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250417031208.1852171-1-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

check-parallel ensures that it doesn't overwrite results by creating
date-stamped results directories. This, however, makes it harder to
easy find the results for the test that is currently running or has
just completed.

To solve this problem, maintain a symlink to the latest results
directory so that it can always be found by the same name.

Also, if this symlink exists and is valid, use it as the source for
runtime ordering data for the next run instead of trying to find it
via ls and sort based ordering.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check-parallel | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/check-parallel b/check-parallel
index 374ac8e96..1b67709a2 100755
--- a/check-parallel
+++ b/check-parallel
@@ -149,7 +149,9 @@ if [[ $runners -le 0 || $runners -gt 1024 ]]; then
 	usage
 fi
 
-if [ -d "$basedir/runner-0/" ]; then
+if [ -L $basedir/runner-0/latest-result ]; then
+	prev_results="latest-result"
+elif [ -d "$basedir/runner-0/" ]; then
 	prev_results=`ls -tr $basedir/runner-0/ | grep results | tail -1`
 fi
 
@@ -325,6 +327,9 @@ runner_go()
 	mkdir -p $TEST_DIR
 	mkdir -p $SCRATCH_MNT
 	mkdir -p $RESULT_BASE
+	rm -f $me/latest-result
+	ln -s $_results $me/latest-result
+
 	rm -f $RESULT_BASE/check.*
 
 	# Only supports default mkfs parameters right now
-- 
2.45.2

