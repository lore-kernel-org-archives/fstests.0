Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FA054A7DD
	for <fstests@vger.kernel.org>; Wed, 14 Oct 2026 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990343; cv=none; b=QHqAnK1aH1vHIYlGbaeCLR+hgRdl+zh3PQq5ZIJx3yUSBfcpue/dsKm/E7iHRVOS+JqFJIycLgUCvLp8GnD2mwkE/Ob1YB3nrFXJHKS55c2pX2HHi/U54vd8sojV6yYV2W7Ki9EeW6uqB0AwUdrutfnMUtBdAubFpD+4ifuaSX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990343; c=relaxed/simple;
	bh=H+HC/psoeTeEGqk6AJBRTPdu/0ZIFspQ717GJI+DN6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E44Az9zK5RqiHi1ucJ6q6fjinJvFa43XEiaiufgqkeCdddOdeJ2w0SWRaD9op51DNXBASAARp6MLMyQP6jXa1UziUILHG4JVr4wv1jYnYF9TI9frL5T7KLk3he4iClkcj2bMdKE54dPxedPb5cWg6f3nqTYy35Ynjo+LcOTVWQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drPbffD3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drPbffD3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228D71F000C4;
	Wed, 14 Oct 2026 15:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791990340;
	bh=+CqZ9C3Qf/n5xSgIoO96k9CUrijAYS3xSrW8VVlV5H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=drPbffD3OBU8TDtbsT9R6tRWsSqHFm4+PeN1HXNDtya5WLRakh42N6+VSWG405SGj
	 XWRoQlIOnEvDdyN6Z1nocJM8+fZnCO1Ho3RBOtJjb39HvJSITfej8aAnrQ3mUAaeLS
	 13D0dD5zfsBf5AsiwJcAVv4TsT5RZ/cAApBCP8UCq6yQZifUthBIroViyY6fA7Ctoi
	 2JOOPNBd5Zs385r0MDdGEIkNUOPyOpUcIuCbwI2rOCtTXi3bR4HACAWQQ8fIe22u71
	 bPFKFamEq5rkNSfxjss0Pzz9y3ewi6jTTEIo6H0bwXsQaQvnzsSqfvOXkn/Tvlg5TR
	 MWOQRhlKzJY0w==
Date: Wed, 14 Oct 2026 23:05:34 +0800
From: Zorro Lang <zlang@kernel.org>
To: =?utf-8?Q?Cl=C3=A1udio?= Fernando Pinto <claudio@studiomoob.com>
Cc: fstests@vger.kernel.org
Subject: Re: Thank you =?utf-8?B?4oCUIGZz?= =?utf-8?Q?x?= and log-writes in
 MoobFS's test suite
Message-ID: <as-ZsZ1ga1M7kX3S@zlang-mailbox>
Mail-Followup-To: =?utf-8?Q?Cl=C3=A1udio?= Fernando Pinto <claudio@studiomoob.com>, 
	fstests@vger.kernel.org
References: <CACU5Mh-+Br5Haf=h+bihpF4qBuS0WmaFZW3zsBBc+PXG+ZB0=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACU5Mh-+Br5Haf=h+bihpF4qBuS0WmaFZW3zsBBc+PXG+ZB0=g@mail.gmail.com>

On Mon, Oct 12, 2026 at 04:30:55PM -0300, Cláudio Fernando Pinto wrote:
> Hello fstests maintainers,
> 
> I maintain MoobFS (https://github.com/studiomoob/llmoobfs), an
> experimental, GPL-2.0 Linux kernel layer that stacks over ext4, btrfs
> or XFS and gives LLM-agent memories typed attributes and an in-kernel
> query.
> 
> We vendor fsx and the log-writes replay tool from xfstests, unmodified
> at pinned commits: fsx runs on every lower filesystem in our test
> suite, and the dm-log-writes replay is one of our power-loss acceptance
> gates. Thank you to everyone who maintains them.
> 
> We list every work and project we relied on, with verified citations,
> at https://github.com/studiomoob/llmoobfs/blob/main/docs/references.md
> Nothing is needed from you; if you ever have comments or see something
> we got wrong, they are very welcome.

Thank you for your kind words.

While fstests cannot officially add out-of-tree filesystems to its upstream
support matrix, there is certainly no problem with out-of-tree projects
forking the codebase to maintain and use it for their own needs, that's what
open source is all about.

At the same time, if you ever make general improvements, bug fixes, or
enhancements to tools like fsx or the replay utilities, you are always more
than welcome to send them back to the mainline fstests mailing list as patches.
Contributions and feedback are always appreciated.

Thanks,
Zorro

> 
> Best regards,
> Claudio
> studiomoob - https://github.com/studiomoob/llmoobfs
> 
> 
> -- 
> Cláudio Fernando Pinto
> claudio@studiomoob.com
> www.studiomoob.com @studiomoob
> 
