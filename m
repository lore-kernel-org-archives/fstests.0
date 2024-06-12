Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402B71DFF0
	for <fstests@vger.kernel.org>; Wed, 12 Jun 2024 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209799; cv=none; b=XGEUP42mKx/eUce9RgnJl+WDgu2N5O3/zpVjmK5kRb8KPH/RUextdos5G1PUjsYTVNz2TIyJ4yQrr9QB/DcBX5u6IBkqQ9L7Lrhy3Gavn1Zwvxuhc4rmIFRCU4q+6UfCkXxgSSAX94iHjj0zMbmBiTN9g68aV/mhRivQy3sqs+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209799; c=relaxed/simple;
	bh=NPjrOI1u6ZwklqagzTtS2IYTxQHmvtjZ9iUd+Nesbsc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d3Zm7jQDvvDTC/mrfExEvQHnPkoeS8DNSXkKrJv8AxPoSa+oNYGnj3fkAsHqw/1Pl3qDiLDA+7J9ktW9vE8fA4cs3XHO19GWLn4yyVh5UQB0ei/249f5m9rWsJf55QRwgs9wXqI+szdErh+DLY7owrwQ+nMF5gBoKwRS812sHJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=UyCEx/Jf; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="UyCEx/Jf"
Received: from macsyma.thunk.org ([204.93.149.36])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45CGTnap031394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 12:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1718209793; bh=Rn3WxPi+HKsTVNrDA9NAdBm1/yD+/Z7Mjn3olzC9d8s=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=UyCEx/JfydQlsRguZiYq6dVHQXfQdp8oab81xywQDQmjlc2XXzOc6JNIB1KbSJUSo
	 LqxV9AXSqDPnhoYLO3fNHfKAXIo0MI/UWRJi9tK+Yo+w3XuWvbeUgUWXj+2Tpfxbqm
	 z0j2XB/r6vciuI+ccAhX/YfMh3MytVZnUZ8c0qEHSc0tgGLTMhixVC6i6OHB+7Vpnn
	 R3c4pbru68yp7NCtqlgzkfj/QL4J9rXquLLH3I6S97VeNrdT/I0Mi1WBINdHZKCSbq
	 zpXOm0omOyvDLVc8HaCb7GuTPNZpswuGZx7NDp3apvGEKZuT+B0aKcUObeoPxYf4hf
	 hj5qjdzbJsNPg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id CF8F934167F; Wed, 12 Jun 2024 18:29:48 +0200 (CEST)
Date: Wed, 12 Jun 2024 17:29:48 +0100
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        fstests@vger.kernel.org
Subject: Flaky test: generic:269 (EBUSY on umount)
Message-ID: <20240612162948.GA2093190@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've been trying to clear various failing or flaky tests, and in that
context I've been finding that generic/269 is failing with a
probability of ~5% on a wide variety of test scenarios on ext4, xfs,
btrfs, and f2fs on 6.10-rc2 and on fs-next.  (See below for the
details; the failure probability ranges from 1% to 10% depending on
the test config.)

What generic/269 does is to run fsstress and ENOSPC hitters in
parallel, and checks to make sure the file system is consistent at the
end of the tests.  Failure is caused by the umount of the file system
failing with EBUSY.  I've tried adding a sync and a "sync -f
$SCRATCH_MNT" before the attempted _scratch_umount, and that doesn't
seem to change the failure.

However, on a failure, if you sleep for 10 seconds, and then retry the
unmount, this seems to make the proble go away.  This is despite the
fact that we do wait for the fstress process to exit --- I vaguely
recall that there is some kind of RCU failure which means that the
umount will not reliably succeed under some circumstances.  Do we
think this is the right fix?

(Note: when I tried shortening the sleep 10 to sleep 1, the problem
came back; so this seems like a real hack.   Thoughts?)

Thanks,

     	      	   	      	     - Ted

diff --git a/tests/generic/269 b/tests/generic/269
index 29f453735..dad02abf3
--- a/tests/generic/269
+++ b/tests/generic/269
@@ -51,9 +51,12 @@ if ! _workout; then
 fi
 
 if ! _scratch_unmount; then
+    sleep 10
+    if ! _scratch_unmount ; then
 	echo "failed to umount"
 	status=1
 	exit
+    fi
 fi
 status=0
 exit


ext4/4k: 50 tests, 2 failures, 1339 seconds
  Flaky: generic/269:  4% (2/50)
ext4/1k: 50 tests, 5 failures, 1224 seconds
  Flaky: generic/269: 10% (5/50)
ext4/ext3: 50 tests, 1477 seconds
ext4/encrypt: 50 tests, 2 failures, 1253 seconds
  Flaky: generic/269:  4% (2/50)
ext4/nojournal: 50 tests, 1 failures, 1503 seconds
  Flaky: generic/269:  2% (1/50)
ext4/ext3conv: 50 tests, 4 failures, 1294 seconds
  Flaky: generic/269:  8% (4/50)
ext4/adv: 50 tests, 2 failures, 1263 seconds
  Flaky: generic/269:  4% (2/50)
ext4/dioread_nolock: 50 tests, 3 failures, 1327 seconds
  Flaky: generic/269:  6% (3/50)
ext4/data_journal: 50 tests, 1 failures, 1317 seconds
  Flaky: generic/269:  2% (1/50)
ext4/bigalloc_4k: 50 tests, 2 failures, 1193 seconds
  Flaky: generic/269:  4% (2/50)
ext4/bigalloc_1k: 50 tests, 1259 seconds
ext4/dax: 50 tests, 5 failures, 1136 seconds
  Flaky: generic/269: 10% (5/50)
xfs/4k: 50 tests, 3 failures, 1211 seconds
  Flaky: generic/269:  6% (3/50)
xfs/1k: 50 tests, 1219 seconds
xfs/v4: 50 tests, 4 failures, 1206 seconds
  Flaky: generic/269:  8% (4/50)
xfs/adv: 50 tests, 1 failures, 1206 seconds
  Flaky: generic/269:  2% (1/50)
xfs/quota: 50 tests, 2 failures, 1460 seconds
  Flaky: generic/269:  4% (2/50)
xfs/quota_1k: 50 tests, 1449 seconds
xfs/dirblock_8k: 50 tests, 1 failures, 1351 seconds
  Flaky: generic/269:  2% (1/50)
xfs/realtime: 50 tests, 1286 seconds
xfs/realtime_28k_logdev: 50 tests, 1234 seconds
xfs/realtime_logdev: 50 tests, 1259 seconds
xfs/logdev: 50 tests, 3 failures, 1390 seconds
  Flaky: generic/269:  6% (3/50)
xfs/dax: 50 tests, 1125 seconds
btrfs/default: 50 tests, 1573 seconds
f2fs/default: 50 tests, 1471 seconds
f2fs/encrypt: 50 tests, 1 failures, 1424 seconds
  Flaky: generic/269:  2% (1/50)
Totals: 1350 tests, 0 skipped, 42 failures, 0 errors, 35449s

