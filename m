Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F491DA21
	for <fstests@vger.kernel.org>; Tue, 27 Feb 2024 05:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709011140; cv=none; b=p+X/cUR4X6OQ2c4I2Wnt5j6oCzhD5NLYPZzJt3k3ZgxLQG5ItP49LdGpxb2RzUtYDESxr/Oa8uG8t68G7PHheqUN3JxoiJ1XJBu+KdOusUJUQcX5FdFQyHJy4qre43Q7w4vWGuuvNhL1ZAII2K8McdJaY6byp8LMVjdteCjI9r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709011140; c=relaxed/simple;
	bh=yFZEzLefqdMDb7L2c7cl/QhgaLG8s0e6WVL8YGOMVPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJNZxRw31q7A/HuU3wB3wAD3ziJ+41kMznR3aeN8Vy3mYJ/VO20TJNQeYruTTUtBV4JSC+ORFPbmclLD5GyaYH2gRBmr8aeTLvvbQLqughVD80j30JrAWnK1Of0hbEDsAa5EIY+EOVqtlV+7U+r831cQJf6RmGtVWqNJos3K56w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHtKabf7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHtKabf7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C7BC433F1;
	Tue, 27 Feb 2024 05:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709011140;
	bh=yFZEzLefqdMDb7L2c7cl/QhgaLG8s0e6WVL8YGOMVPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cHtKabf7gERq95rGG820boM4MIyGBhbAh+ZnzSVuBy13rdqnLP2IQ4J5h7B/XCxg3
	 6UnciH546BUWH6OGgBp6RgyBu9CfbVWGiZK0cbPKgq5aW2dPxDzpX91yD+Pf+VLinP
	 4BjJObE4OqyZitN0SIwcTwHXad8DXgzzvGtaVlCfplwGUq5lkf01/Gy8O8ENt2LHZw
	 baEhrdHVuFOwoThmd4IVckBMBG+j2C/SoxHR9MSWdd64DqWTJ5OGNcCLxtopZh6VJK
	 gZ84N+HsmNqQFQlfZLTsf7MUaT/LssuwrvS58GYiizzKW9nH1kXHhXuTZeb1RudeXG
	 zb9sQODtZogoA==
Date: Mon, 26 Feb 2024 21:18:58 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, David Sterba <dsterba@suse.cz>,
	fstests@vger.kernel.org
Subject: Re: Dangerous commands (was:[ANNOUNCE] fstests: for-next branch
 updated to v2024.02.04)
Message-ID: <20240227051858.GA1126@sol.localdomain>
References: <20240221140951.GJ355@suse.cz>
 <20240225151616.owk5v4ioplhrioe6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240225165128.GA1128@sol.localdomain>
 <20240225170304.GO6188@frogsfrogsfrogs>
 <20240225174527.GB1128@sol.localdomain>
 <20240226185620.GS6188@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226185620.GS6188@frogsfrogsfrogs>

On Mon, Feb 26, 2024 at 10:56:20AM -0800, Darrick J. Wong wrote:
> > > > "--" prevents the following arguments from being interpreted as options if they
> > > > begin with "-".  That's a good practice, but it doesn't help with ${FOO} being
> > > > empty.  To cause the script to exit if ${FOO} is empty, it can be written as
> > > > ${FOO:?}.  Alternatively, 'set -u' can be used.
> > > 
> > > I said that four days ago.  Did nobody receive that reply?
> > > 
> > > https://lore.kernel.org/fstests/20240225165128.GA1128@sol.localdomain/T/#m0efd851c5a1fb0dbe418f4aff818d20f4355638b
> > > 
> > 
> > You didn't mention the :? option, and I thought that would be worth mentioning.
> > 
> > Of course ideally -u would be used everywhere, as you said.
> 
> Yes, but why not reply to my reply instead of replying to the original
> patch as if I'd never said anything at all?
> 
> The background on that -- I've been noticing the last couple of years
> that every now and then I'll reply to something; then a day or two go
> by; and then someone else will say the exact same thing I said.
> 
> However, they don't simply reply to my email with "Yes, what Darrick
> said".  Often the reply literally reiterates what I said.  That makes me
> feel invisible, which isn't great.  Then I do some digging and usually
> find out that actually no, it's that Microsoft or Google or vger smtp
> servers are either (a) broken or (b) their AI have decided that I am a
> spammer or (c) maybe I actually /am/ in everyone's killfiles due to the
> sheer volume of patches that I send to the lists.
> 
> Regardless, every time I see that I start worrying that email is broken
> yet again.
> 
> That said, I'm not complaining about your specific behavior, Eric; I'm
> putting out there that I don't trust our review process at all anymore.
> <sadface>
> 

I did receive your email.  I just happened to reply to Zorro's reply instead
because it was more recent, was discussing the same topic, and I was adding some
new information anyway.  Sorry for trying to contribute.

- Eric
