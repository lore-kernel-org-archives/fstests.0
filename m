Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4101211713
	for <fstests@vger.kernel.org>; Mon,  1 Apr 2024 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964768; cv=none; b=tGvfuw2gQc2iGlqgSnfMHdsIO67k5zlF1syEhIgeH6ZcefpcHOJ2FsLV5dqkNhz6fo1Ur3WgnZ0hIhzWhst4wRr8sxqDtvKeqU6+BmOhI+TXpr/zHjvdSE/9LZny2FmyzFZoeufvLwEHeLBx80PlVh+kDPKAGhHw2V6boswNx2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964768; c=relaxed/simple;
	bh=CA5NOedA8jWAyQ2Y/OjYbahReHBh4P1RcYxwELeD2pQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EeokBsxJBvUqPMVzLSfxvqk7KxuswMAJfov8gMOlkSJ/8Sz1inOZiNfrBcNGPfbBIFr2IYd6pEPYQN+L+PkERbhrsBEbiYLujPkjRbEO/+UlCYkFXuXMAp0ZDA04R+YRUipmKT6oCc1XHAyF4y62D11PSDLNNnLO31/1EMgwfGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MFlIdQI/; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MFlIdQI/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711964759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CxmNsGmiqhk0aEW8I9hcBmdkKZbCD7jTlOqjoPz8QQ8=;
	b=MFlIdQI/vYCiASSkGyOBY7I/ef2HKepUEI/Epe4ZocEnQRPh4VBiqmJ1Zgpb0mMMmXeWc0
	g3vjJx+jKxGWD1MtEwNU28jCkdX6t6ooALdrG/0zQl7dzD5aIHb8sUh7hoz9n533coxOZT
	BSggHxpgfQhFIbNU7ztr6a3ijUXuS/I=
From: Luis Henriques <luis.henriques@linux.dev>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/01{2,9}: remove invalid filesystem option 'journal'
In-Reply-To: <20240329230859.GF6379@frogsfrogsfrogs> (Darrick J. Wong's
	message of "Fri, 29 Mar 2024 16:08:59 -0700")
References: <20240328170620.334-1-luis.henriques@linux.dev>
	<20240329225020.GB1189142@mit.edu>
	<20240329230859.GF6379@frogsfrogsfrogs>
Date: Mon, 01 Apr 2024 10:45:56 +0100
Message-ID: <871q7p8lgr.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Fri, Mar 29, 2024 at 06:50:20PM -0400, Theodore Ts'o wrote:
>> On Thu, Mar 28, 2024 at 05:06:20PM +0000, Luis Henriques (SUSE) wrote:
>> > Creating an ext4 filesystem using '-O journal' will fail with:
>> > 
>> >     Invalid filesystem option set: journal
>> > 
>> > I didn't do any archaeological investigation to check if this option ever
>> > existed, but the two tests using it will fail to create the scratch
>> > filesystems.
>> > 
>> > Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>> 
>> The feature name has never been journal, but rather has_journal.  The
>> reason why no once noticed is because the file system was created by
>> the _require_attrs before the attempted _scratch_mkfs_ext4.  So when
>> _scratch_mkfs_ext4 failed, it was a no-op that didn't actually do
>> anything, and there was still a file system the default configuration
>> for the test scenario.
>> 
>> What puzzles me is why there was an attempt to enable the journal
>> feature in the first place.  As near as I can tell, the tests don't
>> change what gets tested whether or not the journal is enabled.
>> Darrick; you had added these tests were you were working on ext4's
>> metadata checksum feature; do you remember your thinking at the time?
>
> "Qwklgjwlqaetwqjetlweqqlgqgqtrrt", most likely.
>
>> In any case, either better fix is to replace:
>> 
>> _scratch_mkfs_ext4 -O journal > /dev/null 2>&1
>> 
>> with:
>> 
>> _scratch_mkfs_ext4 -O has_journal >> $seqres.full 2>&1
>> 
>> Or:
>> 
>> _scratch_mkfs -O has_journal >> $seqres.full 2>&1
>> 
>> My preference would be latter, since I'm regularly testing with and
>> without the journal, and I'd much rather run the test with whatever
>> configuration I'm currently testing (e.g., ext4/4k, ext4/1k,
>> ext4/nojournal, ext4/ext3conv, ext4/bigalloc, etc.)
>
> I'm ok with either, though _scratch_mkfs -O has_journal is more
> consistent with the way XFS fuzz tests do things.
>
> Sorry about that. :/

Thank you both for the feedback.  I'll send out v2 shortly.

Cheers,
-- 
Luis
