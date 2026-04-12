Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333D7292B54
	for <fstests@vger.kernel.org>; Sun, 12 Apr 2026 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776021839; cv=none; b=YdScquI6nE+k2v7DOuUzKy8ZSRtI7OksRvjJAI2w5wyuTvsVH0ruaUDyuzCSNHpkRR/HqETUe6xkNJpFFNl3Gi9fECzvoF0QIzAmkkwSdOTixOn2Vcs8xe2CA3jh96GGFK/HiK0nFdwgvwQ6YdnYi7vb4LJ9XAGNx1cTdMFuFfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776021839; c=relaxed/simple;
	bh=sgNBMkP0GGtEIMuzluVYoiRSzK/+olc8gCiywqTTLlw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS626xYyCp6sF6tNQAZ9b3qvvQPvbmJnRmYO+wLSzkqJz3DPoQn+HW449+ZWtEeuIx2SzoC8dFh0+yTGOZxwvQb28Kpzdgm+ASbU5OfdevQvhLNFtMFUl8RYAlkC6W3cCUwNsTLAYl+0jIxKG/RTadvDQexaG2MN0I5P3cGp+Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFEHwXqS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFEHwXqS"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ab46931cf1so20764945ad.0
        for <fstests@vger.kernel.org>; Sun, 12 Apr 2026 12:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776021837; x=1776626637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60FosRcJa4XIHeqkb+XsS2tJbJ1E8wWsZRnP3Lrg4Qw=;
        b=kFEHwXqS/5rTc7jxrwGgUyjpHh8y6bNz7oHLTo9OD0yvu8L/LguiQlMhIUgIWnMQKE
         hHJ1MwVvwBfLwSBprm+TiUy6g2NGstD3LsJ9DF1Wed2qaEviYnb6Sj1muKatOGnzcE3w
         foZlBNZGyEIGw/ebp4QIunvTLFC8kfro52MceyO6gxh07JtYrfNDmOLnsMbd3fFi0tt1
         rERMYI7P/9dsRgX/xpCWjbk3nLSrxE7AvD30ppF2ac1t5sr3fTSfc81gh5cN35+LLqTr
         F6KEC7TFqt751070sQik2RhTWM+7ntV79FF/GahDoxuo7qq7Mjg34ytMQyQtT7Cvq1xH
         7wAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776021837; x=1776626637;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=60FosRcJa4XIHeqkb+XsS2tJbJ1E8wWsZRnP3Lrg4Qw=;
        b=cSxrH7PF79JYUciZtoRHpvaOCgamCMHkgeFUxHyNf+mc/zCEgSgnhbMnZjFahSlX7V
         0OCWeX0qy572RP967MpdUnoD3GlizVOYAcb05YeAg56LH5cZxZwXgGtrbsaC9XCanz8S
         e2c7bqqIZ1dlfpEQEQZBMOxbVFuJTOuvS+2KteWOcNo3Q4u7QqDbHxPEAk8xkEPxnkdT
         8o5iEPEVbar9ByltZORtXqfshMzX4eHcGr8ESVBedsmk35EchcBDNSg7L6UxUaiO3+ZU
         qOy/pdBeBUNJAIvFv4KxmTpePRG722l9W7lddXfbwr/N86f4E7yfgiJwSLlbvn7nG47o
         6hNw==
X-Forwarded-Encrypted: i=1; AFNElJ8AqQfDRusVftRrtgfd/5hGsx4jnWqCVYhdQlCRcX5YY41vbI1FqR34urct8D6BO2gku34XK5kJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyatDmjl+5t/5fUa3fhPOkfOP05t5HfPsUBREjOUQIFF5htNxVy
	nFXPqBOL+L40VFXob//vZaloNvdi5sWiZ5clrQ8abgk+5gLxIpT7it80
X-Gm-Gg: AeBDiev4RPVmmBbIWHSnKgBN8TLvcBdDqJk9TuMFEMLNmj8Mf0CmgDJN77wQcINd+of
	5suuQa/yN4sYzhT2nIm+hrr1RMDuE7Q5TRkIwnn9qy3r6guJsU1RGFr/l7N0pfq+RvENKQCzBJm
	yW8SuNmdWg5z8q07DNrLX0ruDhGjRIFw7CWGvhS+K5RsRL0JahWd93tZeGKr+a6/hZuXT5bGZer
	bm7U0c1s8vttZLpGC/bV0bwOSL07AUWT4av/lUixlb+fC+jcRrTs0RlGemIXXrABxtjW6ZwmQWu
	h5q9CVwtaJSxsY+6ETjVg0AIHf/o+yuGNSsQAQDiOnY3CQ89hjJ5vJ7cnsJDy/SJegZxYpd0qT4
	BchDMTbqMZqqmAhwx9i1oypF4OOb2bm21fZmmrxj/wZmfrhVoXTYnNQ0PsqXg2FmkjN4Lr7ffH7
	S3X47ewjs6NIYbyt9CIjolJ5Io0bQCmro=
X-Received: by 2002:a17:903:2ed0:b0:2ae:5346:d4e6 with SMTP id d9443c01a7336-2b2c73a4423mr137636205ad.28.1776021837474;
        Sun, 12 Apr 2026 12:23:57 -0700 (PDT)
Received: from zlang-laptop ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4df9bb8sm91876595ad.30.2026.04.12.12.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 12:23:57 -0700 (PDT)
From: Zorro Lang <zorro.lang@gmail.com>
X-Google-Original-From: Zorro Lang <zlang@kernel.org>
Date: Mon, 13 Apr 2026 03:23:51 +0800
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, fstests@vger.kernel.org, 
	fdmanana@suse.com, ritesh.list@gmail.com, naohiro.aota@wdc.com, wqu@suse.com, 
	Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 4/6] generic/765: Ignore mkfs warning
Message-ID: <advsFWodVwUXDrVS@zlang-laptop>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>, 
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, fstests@vger.kernel.org, fdmanana@suse.com, 
	ritesh.list@gmail.com, naohiro.aota@wdc.com, wqu@suse.com, 
	Disha Goel <disgoel@linux.ibm.com>
References: <cover.1775802601.git.ojaswin@linux.ibm.com>
 <afee4fedcc9b3685df0e05800d82b88d27f977f8.1775802601.git.ojaswin@linux.ibm.com>
 <20260410165435.GU6212@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410165435.GU6212@frogsfrogsfrogs>

On Fri, Apr 10, 2026 at 09:54:35AM -0700, Darrick J. Wong wrote:
> On Fri, Apr 10, 2026 at 12:06:04PM +0530, Ojaswin Mujoo wrote:
> > This test validates atomic writes for all possible block sizes. In ext4, for
> > smaller block sizes with configurations like:
> > 
> > export MKFS_OPTIONS="-O bigalloc,quota -b 65536 -C 131072"
> > 
> > The output can get corrupted with warnings like below because clustersize
> > more than 16xbs is experimental:
> > 
> > + 16 times the block size is considered experimental
> > 
> > Hence pipe these to seqres.full to avoid false negatives.
> > 
> > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Seems fine, though I think I'd rather mke2fs get patched to fix this.
> 
> I'd let the maintainer decide if he wants this, but ... I'm not sure if
> he's actually going to receive this message. :/

Hi Darrick and folks,

I'm back.

I apologize for the silence these days. I had planned to do a release last
week, but a sudden big regional layoff and immediate cutoff of all connections
caught me completely off guard. Beyond losing my account, I lost everything on
the company servers, all my documents (including a book I was halfway through
writing), my code, and my entire environment for handling emails, patches, and
system workflows. (This is a painful reminder to never leave your things on
company server..)

Amidst the shock and grief, I am now struggling to rebuild and reconfigure my
local environment from scratch. I have redirected my zlang@kernel.org alias to
my personal email -- zorro.lang@gmail.com. *Please do not send any more emails
to my old zlang@redhat.com address*. 

Starting tomorrow, I will begin reviewing and merging last week's patches bit by
bit. I still need long time to get my environment and workflows back in order, in
the meantime, I will also be focusing my energy on finding a new job. So I
appreciate everyone's patience and understanding.

> 
> --D
> 
> > ---
> >  tests/generic/765 | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/765 b/tests/generic/765
> > index 09be53db..b7cc70f1 100755
> > --- a/tests/generic/765
> > +++ b/tests/generic/765
> > @@ -64,7 +64,8 @@ test_atomic_writes()
> >      local bsize=$1
> >  
> >      get_mkfs_opts $bsize
> > -    _scratch_mkfs $mkfs_opts >> $seqres.full
> > +    _scratch_mkfs $mkfs_opts &>> $seqres.full || \
> > +        echo "mkfs $mkfs_opts failed"

Now for this patch, I think we can have it for unfixed e2fsprogs testing,
as this test case isn't related with this e2fsprogs "bug", except you hope
to uncover it by this test case :)

Reviewed-by: Zorro Lang <zlang@kernel.org>

> >      _scratch_mount
> >  
> >      test "$FSTYP" = "xfs" && _xfs_force_bdev data $SCRATCH_MNT
> > -- 
> > 2.53.0
> > 
> > 
> 
