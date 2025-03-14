Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8CF204C1B
	for <fstests@vger.kernel.org>; Fri, 14 Mar 2025 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741977470; cv=none; b=ueRhpLpdPuJAAa+SQg/7VL94sXOhSVKxO/sDuC7DK2vfx79YOXOvG4IiO6O3AbgRYzlBYoYuihBD5YKACby7W4C5p36KYOuYm+thEkVtrUlFqLfz+iplW6Y/wZsCsYsWqY8xQ3KleLN28O5fPRAeFEUXoAiMJ4WwScsrIXdbDcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741977470; c=relaxed/simple;
	bh=yWPzfQsQjroAUWyunMIqGtSUQUtmNsSsQVRS8Ib9ah0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=CytpK1aCn2Wro5NN8E/IALL03n9wjo56E5BCHua3YV+vlEK23O5XU4zK1qgLNeAyhrie0k4nN/jEm6o5ItTjzu/r3zo2kpoJ5NZyvJjaGM3hAumLRGrYWdJNEw4JxrBuCaByqtl4ZmUzZ7BobqCTPyj19FnrU/wvvNQOW28r4BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=cRtdKJ/m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uv7EzyY1; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="cRtdKJ/m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uv7EzyY1"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 261491382D5E
	for <fstests@vger.kernel.org>; Fri, 14 Mar 2025 14:37:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 14 Mar 2025 14:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1741977466; x=1742063866; bh=5oYf8SxQ5X
	XHs7Li9pGlIRc1YeguPXGiwIFEtH3dzT4=; b=cRtdKJ/m5ZJUCuxSf6f/T1TbA4
	nnRea3f+HTnuSrADw/oG17Wa+kvw8dUJk+le2H8KbwOLU7PFCO40GbMStakiEX3V
	K7gpbm6Qr+2q9aGBM/aBOi/1Hg7JLOcPfpTd4SIfyWJV1aoUHMT1SXvLnw0n3cou
	3T+C610lqeLy3bBad7Lir2IvzK5WHCSGHbotAXf/LHxIaLG3RppvYYRpFf1Z3E0H
	g7H49/05ufSM1vkNhDZ6m94Xb4pLcWJXQIi95L1yfWPzVbYr+JG8Jn5gucm1Ypox
	/KJ0W5HSm5KSWEew/hyqXlm0IKx1kxVTDVp05DPAHfEmpU0eLeHBt9XNt6LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741977466; x=1742063866; bh=5oYf8SxQ5XXHs7Li9pGlIRc1YeguPXGiwIF
	EtH3dzT4=; b=uv7EzyY1D3WQAJ9q8dgr6JfieIP9EgKCKxWr5icJfriaGdO0u7Y
	uFEEcBe+ax5jt11TXkcRAmtk0PV+/6SoSDZSe+ex1glpl/M2/XY7qgqp+nnY9g+/
	ArAV/QOiMH0A1mvqFWylHHiwRmGidNx6UPVvY6lEr8y4vUhpRkumLNlzqZpM7Rt2
	w9rAn/bnNvCr76zjetP4DKTAzbMweaoQCX23rpNVya0mmZaVVyvZIBeqsvqaQ6y0
	I6v0kcfcc7m46sJ8+fkfld4ctd4AGaZm78xtjNZhaUWOF4vB01NxmpoXN+ahFdgY
	fYEqw4sTFSUXw7HMZLMY9cWNCSyyWWyFRnA==
X-ME-Sender: <xms:eXfUZzIl6aCFZ4cnAvzBtjBq0P2erLh_J5JhJ3na35GiDrwxVAR7mg>
    <xme:eXfUZ3LevegLEoyNbgZv1lQTz7uxUhBxvVtzxjYzJBgBoKVLoF9GejWS98pzuiRoh
    XZum945_jO34-1TEno>
X-ME-Received: <xmr:eXfUZ7t6KpMBgjhq7PkyiOlrt-liKpcYFB6W9aNL_5uU69-C9Snjg7zl0Gc2dQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeduheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefkff
    ggfgfvhffutgfgsehtjeertddtvdejnecuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcu
    oehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtqeenucggtffrrghtthgvrhhnpeejff
    efvdejgeefleffieekuedtveejheduieduffeuledtvdetfeevvdeukefhvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghnuggvvghnse
    hsrghnuggvvghnrdhnvghtpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehfshhtvghsthhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:eXfUZ8avoWZmMqSKGhz4X30x6sgXeGgbDHs0rLGoLu1mvLL7_Z9D5g>
    <xmx:enfUZ6Z_j_HnQmDF-nrpmopk1cA_WOy4vsch-jT8ivxMyCVhJmCjLA>
    <xmx:enfUZwAat-gZmXHafsmWY8X2Oe1dC1nJbzj88wZ_wLZZBLQQYgQhZQ>
    <xmx:enfUZ4aj7wFjTTrdFcoT_5vKn8-0l-bq5Z2k4KmRK9R413I4UOiZjQ>
    <xmx:enfUZ9yt-COYpfaUJNt12jiDUR3ucFQPcNWKV2j0nRfqTOXk-ydps9jr>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <fstests@vger.kernel.org>; Fri, 14 Mar 2025 14:37:45 -0400 (EDT)
Message-ID: <3d35c97d-8c04-4d0b-b7d7-bc689edbc1ed@sandeen.net>
Date: Fri, 14 Mar 2025 13:37:45 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
From: Eric Sandeen <sandeen@sandeen.net>
Subject: [PATCH V3] common/rc: explicitly test for engine availability in
 _require_fio
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The current test in _require_fio (--warnings-fatal --showcmd) does not
fail if an invalid/unavailable io engine is specified.

Add an explicit test that every requested io engine in the job file
is actually available.

Also, remove the "ioe_e4defrag" entries in the [global] stanza of several
ext4 tests which use fio jobfiles. While ioengines can be set in the
[global] section, they can also be overridden in individual, subsequent
stanzas. In each affected test (ext4/301, ext4/302, ext4/303, and
ext4/304) every individual stanza after [global]re-specifies an ioengine;
either with ioengine=e4defrag or ioengine=libaio.

Because of this re-specification, the ioengine in the [global] section
is ignored. This is a good thing, because ioe_e4defrag is not a valid
ioengine, and would fail this new hand-rolled check, even though fio
did not complain.

So rather than over-complicate this new check, simply remove the unused,
invalid "ioengine=ioe_e4defrag" lines in these tests.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

V2: Be Better at Bash, thanks Zorro. Also add | sort | uniq to ensure
    we only test each requested engine once.
V3: I've got a fever, and the only prescription is more pedantry!

diff --git a/common/rc b/common/rc
index ca755055..ac443ec2 100644
--- a/common/rc
+++ b/common/rc
@@ -3977,12 +3977,19 @@ _require_scratch_dev_pool_equal_size()
 _require_fio()
 {
 	local job=$1
+	local eng
 
 	_require_command "$FIO_PROG" fio
 	if [ -z "$1" ]; then
 		return 1;
 	fi
 
+	# Explicitly check for every ioengine listed in the job
+	for eng in `sed -n "s/ioengine=\(.*\)/\1/p" $job | sort | uniq`; do
+		grep -wq $eng <($FIO_PROG --enghelp 2>/dev/null) || \
+			_notrun "fio engine $eng not available"
+	done
+
 	$FIO_PROG --warnings-fatal --showcmd $job >> $seqres.full 2>&1
 	[ $? -eq 0 ] || _notrun "$FIO_PROG too old, see $seqres.full"
 }
diff --git a/tests/ext4/301 b/tests/ext4/301
index abf47d4b..a05b8e8a 100755
--- a/tests/ext4/301
+++ b/tests/ext4/301
@@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
 cat >$fio_config <<EOF
 # Common e4defrag regression tests
 [global]
-ioengine=ioe_e4defrag
 iodepth=1
 directory=${SCRATCH_MNT}
 filesize=${FILE_SIZE}
diff --git a/tests/ext4/302 b/tests/ext4/302
index 87820184..e0f5f2f9 100755
--- a/tests/ext4/302
+++ b/tests/ext4/302
@@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
 cat >$fio_config <<EOF
 # Common e4defrag regression tests
 [global]
-ioengine=ioe_e4defrag
 iodepth=1
 directory=${SCRATCH_MNT}
 filesize=${FILE_SIZE}
diff --git a/tests/ext4/303 b/tests/ext4/303
index 2381f047..0a83e86c 100755
--- a/tests/ext4/303
+++ b/tests/ext4/303
@@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (3+1))))
 cat >$fio_config <<EOF
 # Common e4defrag regression tests
 [global]
-ioengine=ioe_e4defrag
 iodepth=1
 directory=${SCRATCH_MNT}
 filesize=${FILE_SIZE}
diff --git a/tests/ext4/304 b/tests/ext4/304
index 53b522ee..5f2ae4bd 100755
--- a/tests/ext4/304
+++ b/tests/ext4/304
@@ -32,7 +32,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
 cat >$fio_config <<EOF
 # Common e4defrag regression tests
 [global]
-ioengine=ioe_e4defrag
 iodepth=1
 directory=${SCRATCH_MNT}
 filesize=${FILE_SIZE}


