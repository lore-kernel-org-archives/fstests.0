Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD45B1FC0E3
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741301996; cv=none; b=t4uqbbUghuT9DFG4rvpDORlKpiRTtC30N/up807eKB/eX+hpIvJo1sIGc+H1TQ88tmHW6RqViP1UEDrmHgluTIXrhhW3Fba9HpWrXPiG2Fpc7oUst45TWV40NeGtm9LQCE6pkv5PHctMfT57WiAWogqAbufl4LWLHsrsXCMOPXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741301996; c=relaxed/simple;
	bh=b22ERGLYTa8SLbS0uwdfNlonV2RRhisZRx0joXrrGlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnFygWHtu45lpM7wyexjhPFDw8o8I0gSXyuAhyX1ibId63O3Y0NXI324MFA8cBlELama8oroLIB/XQGPvyk8gCA8il9AHcpyyxxzMVpZ2NoGyM9Qm8SzRFCnC+MYCbj2h90o8elsuhLH85ZjNK+XtNrbHSxGZhXBrSHbF7m9BkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3NSzSV4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3NSzSV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D763C4CEE0;
	Thu,  6 Mar 2025 22:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741301996;
	bh=b22ERGLYTa8SLbS0uwdfNlonV2RRhisZRx0joXrrGlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i3NSzSV40Ly9Bd7lx5Smcx4K0Yyf7Z51n8mo4vQc7FsJ0QafaGjHqnDpGHgqXSkPE
	 Us2WQOQawT0hmQHSNvXS+a7hxv8T4n12fc/81Zn400t4x0/prskoejDGPdARgYG2ig
	 Zo4wfML8rfMpv6pc1fp4tMFngLUm5+UEwCZ6K0L+bOGYpLKeaI/oxq3SP0bW+vJk3Q
	 wM9CjANYRoSwxVl6Fx9LdlgUUjsaQ+mV74B4MuEJ5na9XPS3fUGoGyPTT6rddd2ElC
	 3T+QKQumcJfhNmMLZHfkZ9axZkAtMTRGkQxInS/pnmWFhP5mxDju6SGF2szCIF5tG/
	 spqVv3kGOiQow==
Date: Thu, 6 Mar 2025 14:59:55 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 0/5] fstests: remove old SGI QE scripts
Message-ID: <20250306225955.GF2803740@frogsfrogsfrogs>
References: <20250306213921.3769440-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306213921.3769440-1-david@fromorbit.com>

On Fri, Mar 07, 2025 at 08:34:45AM +1100, Dave Chinner wrote:
> Hi folks,
> 
> The scripts this patchset removes are historical relics. They
> haven't been maintained, in many cases they don't work, and in a
> couple fo cases they are reliant on test machines that SGI
> decomissioned almost two decades ago.
> 
> There is no point in trying to maintain these scripts, but they
> still create dependencies on common fstests code that is now getting
> in the way of making changes to fstests infrastructure.
> 
> Hence we should simply remove them and get rid of all the technical
> debt they contain with them.

The whole set looks good to me -- I've definitely never needed, used, or
noticed the old SGI scripts.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> -Dave.
> 
> 
