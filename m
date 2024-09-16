Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840611757D
	for <fstests@vger.kernel.org>; Mon, 16 Sep 2024 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726521493; cv=none; b=tCToUfMoH6D+SIESHvZ84YHiguIEm6YlYAPm9LlsI5KNXvprRF/yTuNw+8+C5PHjXnYku9cfJoC+MeE7Lpx65exwpHN5pXZnDw2S4d+h+ERXYbov/DSf9hWgCEBnpw2mh/UGm6ELiweJAf4Wa4hVQr1M0iEVWHO9izSXq/zubB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726521493; c=relaxed/simple;
	bh=1WEuoMDH5sw2/G1fmnHxPmSwt14dWB7etl2HJDOGn0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YV7pq0Kf9MlzD5mLxiMNMNvPBn/QTw7bz3qEDOA6FZALsbY88V5cwZNX4n4sLWoqyvuPGe9GDZ5TON2rOFSz7jmbIDF3XOb76EXOZl78/DVKCMFczPnOVpmsbXHYzAfxLOFkW8/7l9d+Y8g3pV22RxFkhldX5x7wfM9FltBfVKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhrABw3Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhrABw3Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0381C4CEC4;
	Mon, 16 Sep 2024 21:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726521493;
	bh=1WEuoMDH5sw2/G1fmnHxPmSwt14dWB7etl2HJDOGn0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GhrABw3Z5gsLOO64cErrRof9cvBAwnY6U9as3N8Fypt3bujrEnIBa3MRF2GcRA8cJ
	 iZ2u1Ub73IDN9t4LRGM3HIgdAH7i+/mGxsp3evklFZfLO/aYzaaPQkMr4qQH6tPs/a
	 EIi9+tGUrRO1vm5IptIzwbuNyRiaGtOG0+SIJGFYsKxEdGYkBNG9dBMJNF5uu+gsHR
	 nNFOARmMnYqE9pZrnc51BLnVmg7RTHFq6FRyEHrFCXUYx/5vstnMvo8yv5ecTMv1KH
	 4VHc3UMmo53ctuCa/09nSkecunKyZTXIX1TsOmj+3CGW81CS3eTSGPCIb/Of8YtRzc
	 wEJxqEzfDHEwg==
Date: Mon, 16 Sep 2024 14:18:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Broomfield <mattysweeps@google.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/375: clarify flipping the write bit
Message-ID: <20240916211812.GA182183@frogsfrogsfrogs>
References: <20240801230417.323994-2-mattysweeps@google.com>
 <CALEiSPwGymqrBDiQ0sH1Vwmg9uzJ4KBe5tWx+BA_Vv4p0gvj_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALEiSPwGymqrBDiQ0sH1Vwmg9uzJ4KBe5tWx+BA_Vv4p0gvj_Q@mail.gmail.com>

On Sat, Sep 14, 2024 at 01:18:03PM -0700, Matthew Broomfield wrote:
> On Thu, Aug 1, 2024 at 4:04 PM Matthew Broomfield
> <mattysweeps@google.com> wrote:
> >
> > When checking if SGID is cleared upon chmod / setfacl the write bit is
> > flipped just to make sure permission changes are happening. This is
> > orthogonal to testing SGID.
> >
> > Added this information to the test description.
> >
> > Signed-off-by: Matthew Broomfield <mattysweeps@google.com>
> > ---
> >  tests/generic/375 | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tests/generic/375 b/tests/generic/375
> > index eb675144..44670350 100755
> > --- a/tests/generic/375
> > +++ b/tests/generic/375
> > @@ -7,6 +7,9 @@
> >  # Check if SGID is cleared upon chmod / setfacl when the owner is not in the
> >  # owning group.
> >  #
> > +# The test flips the write bit to easily observe that chmod / setfacl are
> > +# successful. This is unrelated to testing SGID.
> > +#
> >  . ./common/preamble
> >  _begin_fstest auto quick acl perms
> >
> > --
> > 2.46.0.rc2.264.g509ed76dc8-goog
> >
> 
> Hello, can someone review if the comment in this patch is accurate?
> Thanks in advance for your time.

I don't understand this new comment -- "flipping the write bit" is what
the chmod does, and that's what clears setgid.

--D
