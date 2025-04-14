Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC76A290088
	for <fstests@vger.kernel.org>; Mon, 14 Apr 2025 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628998; cv=none; b=RthlGRf9qilEgWgnHo+Tz5CgtXCKgwFBb4vucysCm12F9h0EIesgIw3L8ZX2QTG1MWK/MlZ5hITYiKF9k8q4fZWwyD4DPD+vIXPm1r006oKdkqek+7ArvUmDq3TUHqRCYU2v2q4Mm293KFDmfYyvMC5w4KVmOLxDEtLDdbuAPC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628998; c=relaxed/simple;
	bh=q08922A4yKgEH82yvFth/K+0rlyEy0HZrUqvhFgN6pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vxny1/93QsfCG5r051aA/ox0ZTaoLuZNQ/HLMxblHf70qxEeimfM0qceST9eIYK8ZuWWT5w/uRdqn2jKIiKLlMHjrLnwlU93GTZDY3F4e4JFppzA5OtIu+jXxCEDueVUENNwtLGj9JFhnj/Zkg/nlmlrz5CY5/OUwINkQ1fisDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uuqOhQnz; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uuqOhQnz"
Date: Mon, 14 Apr 2025 07:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744628983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FQ3mkGGw8Px2MJlSAKgdSW9a06mMz6yRygMq5HG+vX8=;
	b=uuqOhQnzDrweD6ONhFmlYBc8f2GebBEemmxwH6/rVmtv4I7ZHJaxuX05Yr8EQfK8wzogbG
	8Tm9hF2Mop+rQfoWsoDwPZZ1f71Bj6lY59IMNQ8CptTB07b8DDQykSdBmZZ1zhUNOLTnMr
	EjmY0Y+4nIOa5VhSjOQar4BGwI7+K5c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Zorro Lang <zlang@redhat.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org, 
	David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] README: add supported fs list
Message-ID: <rh6l7ugjga6xj22wipaxrpveyxthpgngntdhp3czgatccdkz7w@sqbph4huj7fr>
References: <20250328164609.188062-1-zlang@kernel.org>
 <u2pigq4tq5aj5qvjrf3idna7hfdl6b4ciko5jvorkyorg25dck@4ti6fjx55hda>
 <20250414055857.w2zvapp3mjintgar@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414055857.w2zvapp3mjintgar@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 14, 2025 at 01:58:57PM +0800, Zorro Lang wrote:
> On Sun, Apr 13, 2025 at 05:56:08PM -0400, Kent Overstreet wrote:
> > I heavily use xfstests and look at the test results every day - I
> > believe that would indicate L3.
> 
> Glad to receive the response from bcachefs :) L3 means there're enough fs specific
> test cases in tests/$FSTYP besides generic cases, e.g. tests/overlay, or f2fs (although
> it only has a few currently, but it's increasing).

Active support for existing tests, or writing new tests?

To be blunt, fstests is not a great environment for writing tests, the
'golden master' model of pass/failure means debugging test failures is
archaic.

But those tests do get run and used, with active support.

> > bcachefs specific tests are not generally in fstests beacuse there's
> > lots of things that ktest can do that fstests can't, and I find it a bit
> > more modern (i.e. tests that names, not numbers)
> 
> ktest? linux/tools/testing/ktest/ ? I'm glad to learn about more test suites,
> I run fstests and LTP and some others too, fstests can't cover everything :)
> Hmm... about the names... fstests supports to append a name to the ID number,
> but the developers (looks like) prefer using number only all the time, then
> it become a "tradition" now.

No, not that. Does anyone even use that thing?

https://evilpiepirate.org/git/ktest.git/

It's a full CI - https://evilpiepirate.org/~testdashboard/ci

> 
> > 
> > Not all tests are passing (and won't be for awhile), but the remaining
> > stuff is non critical (i.e. fsync() error behaviour when the filesystem
> > has been shutdown, or certain device removal tests where the behaviour
> > could probably use some discussion.
> > 
> > But if you find e.g. a configuration that produces a generic/388 pop,
> > that would go to the top of the pile.
> > 
> > (I do have a few patches to the tests for bcachefs in my tree that I
> > really ought to get upstream).
> 
> Sure, warm welcome your patches. And don't worry, you can send patch to
> update the level part anytime when you think fstests supports becachefs
> more :)
> 
> Thanks,
> Zorro
> 
> > 
> 
