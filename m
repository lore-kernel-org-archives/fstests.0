Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687533D8915
	for <fstests@vger.kernel.org>; Mon, 27 Jul 2026 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182093; cv=none; b=lWCzrYyjkxnnG35+GnV6RuglyPZDXgf2PV/b+/IYajr+lRUPpaVfiMcyB/Ya2urCC31mCkS/Qbd+HwgBxesgI+QvNkgbex9pYEmXHKvuX0jpdi+4iPNkTy0shlGWC8xuwvvn+al200D0E3C+Bxk++okzMiZcbIIwig2/KnMYgW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182093; c=relaxed/simple;
	bh=ReEao9hh/ZRkzf8UZPdmUpv9mkL4R/6Fzvc6zJjkynw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwLKPasQf7mF8Fmx8QlTjzwouPnP1s0ZOLhYEAIBbdUYZr6e9RUaXlEQlubEJZVV+SWd2fknrhLHOHTQFTe0hixdRnwE52DT+Dx1e2li1iIjvTHhb8qvp1NswbHDlge7DQI/U+YeUFyyaXo13grJfXg4AR9Vl7KdjL9P2ysSpj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqvPhIvB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqvPhIvB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33DD1F000E9;
	Mon, 27 Jul 2026 19:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785182088;
	bh=I4IYv2Kxz0iDat23LTrK+rn4Tt2R76O2CC8p939JSTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NqvPhIvB//ltcOnl2C+NPJ8qP7DnjpyBdUtuiSrlUc027udHoq+/TCfXrcOlwBC+o
	 EcE3vvjzQM1+Sb3e01GZa0aTN+6eujEg0U+wkOacETCNOcgEd1gqHUgXkGBW7x7Q0m
	 MklO/7pXemrwBZEt96w8iG0dS0ukIspNJASOc6avTOEUAsrHYj0z70jxAwC2wk6QAj
	 g6U5lG2eNdD1fHM12uNB3bhmWSRmwChvMQEhbmtVdPBhwcu2ckh8pkDrenasvfaYez
	 NEDnK7PgPXBNYewoShrGX62mlAJQpt7D+YCXHyxIMhDy76DbqTl+FYCODFnV/Nv62p
	 uruyKU4EmtB/A==
Date: Tue, 28 Jul 2026 03:54:43 +0800
From: Zorro Lang <zlang@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2026.07.21
Message-ID: <amey_roTyYfWM6tt@zlang-mailbox>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, 
	fstests@vger.kernel.org, Christian Brauner <brauner@kernel.org>
References: <3a82ff6642f00830fc588026ee521a42@kernel.org>
 <amCGrQi2sCcgSgHL@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amCGrQi2sCcgSgHL@infradead.org>

On Wed, Jul 22, 2026 at 02:00:29AM -0700, Christoph Hellwig wrote:
> >       [1cca2bc0d7a9] fstests: vfstest: skip rejected tmpfile creation
> 
> We should get the original patch from Christian for this instead.

Do you mean this patch?
  [PATCH 2/2] src/vfs: skip whiteout-device fixtures on overlayfs

It's currently still under review, I thought it's an overlayfs fix.

CC'd Christian, sorry for the hassle, but if there's a better fix
coming from VFS, would you mind rebasing it onto the latest for-next
branch? Thanks!

> 
