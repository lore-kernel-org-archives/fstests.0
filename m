Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0F6134411
	for <fstests@vger.kernel.org>; Thu, 29 Feb 2024 20:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237111; cv=none; b=JRnZK/blsvrLNnGxP3CesCtAZaxligkpF5tSttVMSvoCJOBBXBJcBsDSaoMEX9XnSGDbbxB2pyWKSBwZ4Ve4oWFiFqdHxDkyv37tU9SDa6dVBS46gmJxDZDptjIPGeG+ZTS+imBMEvhgba6IMDMpnxInfCa7BK1LONu4LXEbRQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237111; c=relaxed/simple;
	bh=MtiZQBSmnCbnWC4ZC6+ag7RczifXh2zJd8RsBSZcEBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPWEt9YNfkf0Oi+O4WvSGE5x3bwxqv9+W5CHgk5Ub/z8Cdos1dbrxtzSjJD9EqMuSaOnXUdNzbmNqCUlLZKU/vsEC7BEAho/G5EiL9ZNwTWTJGnstggaiXs0uZ6B9SsHty35YixhsYMGIEfkXbeVoHo3gnA5wmLRTUos4fvUIHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCDqCyeR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCDqCyeR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61163C433F1;
	Thu, 29 Feb 2024 20:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709237109;
	bh=MtiZQBSmnCbnWC4ZC6+ag7RczifXh2zJd8RsBSZcEBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCDqCyeRuvYNEIF6Xt1REOgypokftYe72o+zQeFGY+w+2vuX7pUApaJzqEwuKc4fu
	 wUzmtqVlnBoZsov4s5QBzRT8CR7KEz51bTlxi1m0lQb0RtlcnHJBL9NN3pyRlDSAfP
	 4BmzNktb5KPWlS18XU1UkDFh+0Bf04enoaGH96/YbJYNidRudrhn6dOdtD3s7gPioS
	 fd2sJDh0InpGA8UR8DlVGuirAjtTYRPmx1yKtfu7qBokuhvD3OfhdhguBU2dc2lfCW
	 38BkXRjNXGyNd5ymJ5IZ5sGUGbMWCPV2WFztav0widLffmmwSgpEX2WQeCV922QfI6
	 49wWfj0JSh8Hw==
Date: Thu, 29 Feb 2024 12:05:07 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
	zlang@redhat.com
Subject: Re: Dangerous commands (was:[ANNOUNCE] fstests: for-next branch
 updated to v2024.02.04)
Message-ID: <20240229200507.GB1454@sol.localdomain>
References: <20240221140951.GJ355@suse.cz>
 <20240221161358.GM6188@frogsfrogsfrogs>
 <20240229184452.GB2604@suse.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229184452.GB2604@suse.cz>

On Thu, Feb 29, 2024 at 07:44:52PM +0100, David Sterba wrote:
> > I worried about this a long time ago, and tried running shellcheck on
> > the entire codebase.  Thousands of error messages about sloppy quoting
> > later I gave up.  Later I turned that into a patch in djwong-wtf that
> > runs it only on the files changed by the head commit.
> > 
> > It **didn't notice** the cleanup error!  So that wouldn't have saved me.
> > 
> > Long term we ought to rewrite fstests in any language that isn't as much
> > of a foot gun.  Or someone starts a project to set -e -u and deals with
> > the massive treewide change that's going to be.
> 
> I see from your and Dave's response that the problems are known and that
> everybody tried to fix it in some way. What I also see that it's kind of
> futile so that people carry their patches in own branches for testing.
> The amount of treewide changes is probably killing the idea or this
> would have to be coordinated or done in sprints or idk.

At the risk of being blamed for posting a "redundant" response again:

What I tend to do in new shell scripts outside xfstests is use
'set -e -u -o pipefail', and also make sure they pass shellcheck.

For example, I did that for the tests I wrote for the fscrypt command-line tool:
https://github.com/google/fscrypt/tree/master/cli-tests.  And I made the
shellcheck be enforced by GitHub Actions, so new warnings don't get introduced.

So, the point is, I'm very much in favor of 'set -e -u -o pipefail' plus
shellcheck as a modern, less error-prone way to write shell scripts.

What can realistically be done with the existing 170000 (?) lines of shell
script in xfstests is another question.  Perhaps common/ could be updated first,
and then individual tests could opt into strict mode as they get updated too.
It would be a lot of work in any case.

- Eric
