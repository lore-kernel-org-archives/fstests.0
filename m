Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F5C130E5D
	for <fstests@vger.kernel.org>; Mon, 26 Feb 2024 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966624; cv=none; b=ftVhKU3nUPx0gIpcnclCZWTyW1W3JjRSxfc9KYhct4XmQln25NmeH26Xg7BvT7zIlhyrG5fvk8bJNh23Dcdpm0aGZZMvX+JnAlTF1oxpltDo92n1BKqd3c6L/cuiii5azsXUWMcHRHwvQVApMiALrX0ZCC3idA5qKrbSO823TNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966624; c=relaxed/simple;
	bh=MRMjJ6ayspXYKW83CX6njIWs29/9RIw/Kf+SkXCeANA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nV/vvDeVuwxk2sIjIpP9M9pKEvYa/FC1dQPf/A46/+MEHFmQPYGOfC9kAWG12/n+ZtB9PaDao1uy9KUWlZ0wZrmL7mJ7T3Mw1qaf145hc4cW+lGZZjgBU2WltMn9oFLhYNwoM8cktIL45JmZ0ZxCkpnar5n5rC5cOQLya0h1Y2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtRSj6g/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtRSj6g/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C837C433C7;
	Mon, 26 Feb 2024 16:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708966624;
	bh=MRMjJ6ayspXYKW83CX6njIWs29/9RIw/Kf+SkXCeANA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KtRSj6g/V1Z9J1M1J/t+ID3GNynEzEI+Jfnuakpy6R4LD2phmEXKDLkpY0ccnbcG1
	 17VwTYVTHkl2XUGa/G7GVc7oFnAHEJxtmmpIOgSTr+3WEPDM3gAmgBJYZuGVAhwKje
	 fRpxpX6qrrEQPtivCK6hKECevPR03c7ezzf4SAJLSAEsxSMX03zPbo+GGKxouS++DT
	 qKBQjm5Nuq6EHaTaBIjbvLaG7i/ggjd6eoVLzUngq+aXoKl4YoDy9XEupe37003L/I
	 J5PqUNTs1oaMSheGA0gIcFjbgC2p0wjQAM8mMBhvwq28TMeX/oVDvavrDRRTdK1OLK
	 IV82co44qJodQ==
Date: Mon, 26 Feb 2024 08:57:03 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] tests/*/Makefile: make sure group.list DIRT exists
 before install
Message-ID: <20240226165703.GQ6188@frogsfrogsfrogs>
References: <20240208225241.644701-1-martin.jansa@gmail.com>
 <20240225163042.rrb6djrhbs6e2fk5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CA+chaQdFJkmc540nzz0PKJLtXMGg4yCfHYkMZaxCooCZ6PdaLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+chaQdFJkmc540nzz0PKJLtXMGg4yCfHYkMZaxCooCZ6PdaLw@mail.gmail.com>

On Sun, Feb 25, 2024 at 07:01:48PM +0100, Martin Jansa wrote:
> On Sun, Feb 25, 2024 at 5:35 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Thu, Feb 08, 2024 at 11:52:41PM +0100, Martin Jansa wrote:
> > > * sometimes make install was failing with:
> > >   cp: cannot stat 'group.list': No such file or directory
> > >   and bunch of non-fatal messages:
> > >   mv: failed to preserve ownership for 'group.list': Invalid argument
> >
> > I'm wondering ... isn't that expected?
> >
> > Why not let "make install" fail directly, if there's not a completed "make" ?
> > Isn't that more familiar?
> 
> It might if it fails reliably, but in OpenEmbedded builds where I was
> seeing this in some CI builds it failed in about 1% of the builds, which is
> enough to make the failure annoying and if this is meant to be expected
> behavior than not failing reliably, for context see:
> https://git.openembedded.org/meta-openembedded/commit/?id=e8a1c9823b7e55dd2ca7f19a3fd3a05ae676bfe2

Aha, that explains the weird language in the commit message about
"removing tests/*/group.list" and "adding some sleep" even though the
patch doesn't actually do that.

> so here it calls make in do_compile task (defined in autotools-brokensep),
> then make install in do_install task and do_install was failing
> _sometimes_, and I haven't seen single failure since this change was
> applied.
> 
> I'm not very familiar with xfstests, I wasn't even building it
> intentionally (it's just part of one CI job which builds everything
> available), so I might be missing something.

Huh, that looks like the result of make trying to run the 'default' and
'install' targets in parallel because there's no "install: default"
clause in the Makefile.

Soooo... are you folks using 'make -jXX default install' in your CI
system?

--D

> Regards,
> 
