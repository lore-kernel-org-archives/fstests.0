Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8344689
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683556; cv=none; b=q+sql6cb9RtJ230wZjR58UaHGNADzOAErZRHHJS68lCbGIku4NWOnBCA849oBg2Sue1q0m4AU4AuCCTDVOpntxv9ocJghMPV+ChykiBklBMWELRgk6hLLoy6Jm31WOFkV7HPgyBjjIO4dvP/5rSM0aSxg4VrWFVIU0RZsnHNesg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683556; c=relaxed/simple;
	bh=S7Kq+U13M1m8fIBANKREbPc7cch6T7ga0iGYO2E8274=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+3NEalfQk6fpfwkt+TCyTbBAuh7z19uGcnZheYqVvWSQqWFGQOsKo1v/mphv1rLsq6XATwWMmqkT7Fb6OdGthpe10pzZ/AqKDReOWCF83rUVFOzq6c5S5rzHQ7hnuwhyigV4RxIyXl0x08Ak9patzBUgfUVyJIo40j8UCGCneg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=hmzvGR7g; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="hmzvGR7g"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-724e1b08fc7so4639082b3a.0
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683554; x=1733288354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQPQpsFy2U8zfr63hDof0WM2JO5DHeIUTDZDWHFKHHM=;
        b=hmzvGR7g2PX0WbqjPGE51YjNh15LGjJp00jw61U+WaBZa4rk2HFQVZMrTOKm1xE4+v
         ICwngHgNWUvqRQFYnKW1eGFIg0AkanpgEZfkT67OMyrFJKXMlEBGPmf+kYOwlglFasG/
         1Ptl5A7tsuRfHJLkTnetWFxTa7MiyrnMWrVoos8lRd6Ni/dTir7hfFg6IWCqcXpU6lep
         GwCU5DF0NmaRRGETzfv4R1eIcQqu9JHXyuJXqMcOXjbv/XTjAWfvU44WdSrnMggqupt4
         Mu3C7dfP/PmddRkG3WTZLDp9oZ3fTDgN2Nt9morE3+Wx0rJUMq+8pG3z0QHNJMoy4jXT
         UuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683554; x=1733288354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQPQpsFy2U8zfr63hDof0WM2JO5DHeIUTDZDWHFKHHM=;
        b=PGBilrxtYdZ8H0dZOFAL/W6+OpS/bgiaoRJQiPSTYdjw0/02PNoRivQGlvbw3aENzV
         vmCCY2/n554MbBPpkY+BardgiVozBEqfEk+3AJvfGqX+ShUhBiPHFyJh24DjzpNq2lCQ
         pWKu06Wd81Km9ck92PRgyWVuhyjJT332A3vkGXrB7ICT8AtxIsU9r6+TdGH3zNtFdu29
         4gUp4CASsOhXzUjLVuy+IhafYsXARityiZfStz1q42lRlFltHcq1lyMA94LTXkqLO9CI
         WcPpWRODSxADJ/2Dr3A+V9aqEii1wo2w+v74HVcLUUxg7Blf14WmgR8n2Ljo8Jkt1Wm+
         sK1g==
X-Gm-Message-State: AOJu0YzhQx1q5Gzyb3Gbo/jYZ5UovTgsVwJwoNwHT7xSGzlME203XWEz
	2RRFUOy2aH8dAwoWZScjqhK1LN6yjIcnywl7zfJq0bLvNh2gsFYe+4sMElzXlq3QJtINxpkAMJy
	0
X-Gm-Gg: ASbGncu9ztUn7sXZ4yv6J0juwTlQY0iYTpketK/AOT9IS1QjCI924yASNhOcwQzJh1t
	D2ch0qX3laRvWKbfwan9K2SyHseeJka3qTc39PRqKGtNkrAGUx+VDG2/em9aJjaF3HCstlZKMbo
	+2uKiHxS+r0Xr9+mr4Rym7rvcsNbrj48DAziNe6zMO9zLVMTtNFcThSy7uSTUWP6yvWNymH5d0X
	lhBOcY69tyH5FjEBtE3KUgaeFe7CMbP9OZNdQQpKy5ptIIHilSMPFeO67exDnxSjca7vSMmzKYA
	AsTZTlkhQHcJbA==
X-Google-Smtp-Source: AGHT+IG9SX/NC/tgdWpseSoydoAm2c/uukvrBvBfQh3TiRyMsmIEBDiSH8xLmUgD8riF95Db7M2yLw==
X-Received: by 2002:a17:90b:1dc9:b0:2eb:12b0:e948 with SMTP id 98e67ed59e1d1-2ee08eb2b30mr2619074a91.16.1732683554453;
        Tue, 26 Nov 2024 20:59:14 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fab78ebsm499032a91.45.2024.11.26.20.59.13
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:59:13 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZVI-2JvO
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQfJ-2un6
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 23/40] dmesg: reduce noise from other tests
Date: Wed, 27 Nov 2024 15:51:53 +1100
Message-ID: <20241127045403.3665299-24-david@fromorbit.com>
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

dmesg records everything from every test concurrently running, so
noise from other tests can cause multiple other tests to fail
because they detect something from another test. Update the filter
behaviour to minimise this crosstalk problem.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
`
---
 common/rc         | 13 +++++++------
 tests/generic/310 |  5 +----
 tests/xfs/079     |  2 +-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/common/rc b/common/rc
index fdd18a386..3b4b9a59f 100644
--- a/common/rc
+++ b/common/rc
@@ -4591,6 +4591,7 @@ _check_dmesg_filter()
 
 	grep -E -v -e "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low" \
 		-e "BUG: MAX_STACK_TRACE_ENTRIES too low" \
+		-e "WARNING: Reset corrupted AGFL" \
 		$extra_filter
 }
 
@@ -4613,18 +4614,18 @@ _check_dmesg()
 	fi
 	rm -f ${RESULT_DIR}/check_dmesg
 
-	# default filter is a simple cat command, caller could provide a
-	# customized filter and pass the name through the first argument, to
-	# filter out intentional WARNINGs or Oopses
-	local filter=${1:-_check_dmesg_filter}
+	# we always filter dmesg for global things that should not cause
+	# test failures. Custom filters are then applied afterwards.
+	_dmesg_since_test_start | _check_dmesg_filter > $seqres.dmesg
+	if [ -n "$1" ]; then
+		cat $seqres.dmesg | $1 > $seqres.dmesg
+	fi
 
-	_dmesg_since_test_start | $filter >$seqres.dmesg
 	grep -E -q -e "kernel BUG at" \
 	     -e "WARNING:" \
 	     -e "\bBUG:" \
 	     -e "Oops:" \
 	     -e "possible recursive locking detected" \
-	     -e "Internal error" \
 	     -e "(INFO|ERR): suspicious RCU usage" \
 	     -e "INFO: possible circular locking dependency detected" \
 	     -e "general protection fault:" \
diff --git a/tests/generic/310 b/tests/generic/310
index 1ae9e0233..1ab81dd2e 100755
--- a/tests/generic/310
+++ b/tests/generic/310
@@ -46,7 +46,6 @@ _require_test
 dmesg -c > /dev/null
 
 nr_bug=`dmesg | grep -c "kernel BUG"`
-nr_error=`dmesg | grep -wc "error"`
 nr_null=`dmesg | grep -c "kernel NULL pointer dereference"`
 nr_warning=`dmesg | grep -c "^WARNING"`
 nr_lockdep=`dmesg | grep -c "possible recursive locking detected"`
@@ -55,20 +54,18 @@ nr_lockdep=`dmesg | grep -c "possible recursive locking detected"`
 check_kernel_bug()
 {
 	new_bug=`dmesg | grep -c "kernel BUG"`
-	new_error=`dmesg | grep -wc "error"`
 	new_null=`dmesg | grep -c "kernel NULL pointer dereference"`
 	new_warning=`dmesg | grep -c "^WARNING"`
 	new_lockdep=`dmesg | grep -c "possible recursive locking detected"`
 
 	# no kernel bug is detected
-	if [ $new_bug -eq $nr_bug -a $new_error -eq $nr_error -a \
+	if [ $new_bug -eq $nr_bug -a \
 	     $new_null -eq $nr_null -a $new_warning -eq $nr_warning -a \
 	     $new_lockdep -eq $nr_lockdep ]; then
 		return 0
 	fi
 
 	nr_bug=$new_bug
-	nr_error=$new_error
 	nr_null=$new_null
 	nr_warning=$new_warning
 	nr_lockdep=$new_lockdep
diff --git a/tests/xfs/079 b/tests/xfs/079
index 4a1999bb8..3287a20fb 100755
--- a/tests/xfs/079
+++ b/tests/xfs/079
@@ -45,7 +45,7 @@ _try_scratch_mount "-o logbsize=64k"
 
 # The mount may not fail on v4 filesystems. Check for CRC mismatch warning
 # messages to detect failure in this case.
-dmesg -c | grep XFS | grep CRC
+_dmesg_since_test_start | grep "XFS $(_short_dev $SCRATCH_DEV)" | grep CRC
 
 # success, all done
 status=0
-- 
2.45.2

