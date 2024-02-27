Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E0F2033F
	for <fstests@vger.kernel.org>; Tue, 27 Feb 2024 03:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005269; cv=none; b=MEFVzCSviAa19UzRDOvc3r51fF7sFgNPT4+GMpWji23f92HRBfE1lJRUZQWNp3SOgQFFrJqIVCmc8bnVZOPNXCToaUNOyb3c415WByMsXTCerOQqC/NwinWuIjzBD9NtXNH2GAPwmOWQ5SDXpwT6nW9FXjiJlnhB/P+Z91P6ke8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005269; c=relaxed/simple;
	bh=co2qvbtsMCojeVVHvhYXtvcBhwHK5LQG+TZgqcVOYP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRCsl2JweDur0brGL+HjZjULU/a9e4r5/0/Qv7tKAROGnW7FEjPi9/YLP0Tk/er9DZTpbQEIhmnk23TSPcAEbKiHvyoMoaRFn0IMhymkAXrcEXiIIuZG5fyT1B6r78TZmX8JhAAkjPmRZ3rVECNTH+jAOZsh9Hibk3G/hBxl354=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h28PO4cl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h28PO4cl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709005262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pEmOU1GwEZzxAXDV/KJyLGscB5Y/I2xVLuZOKSBMeMk=;
	b=h28PO4clAR5iG7AGn0SFp3JsOjKNe6Ix1HtB1Sza2CXzwbC3oLCv4bzBqeGHLJLB+1+WnG
	NLaYnOIyLFxiE3eQ6VP/fg7NUJQm4+1RoOozhxuEsMML6gXuHYGNVVJ4oECrKyTnmglVLN
	tnY4ROgr46zj/yjx9b4dbNetRPkJ0e4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-C1c6Ws1ZNC27MShwmmaX9A-1; Mon, 26 Feb 2024 22:41:00 -0500
X-MC-Unique: C1c6Ws1ZNC27MShwmmaX9A-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c17cff57f9so2361144a12.0
        for <fstests@vger.kernel.org>; Mon, 26 Feb 2024 19:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709005259; x=1709610059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEmOU1GwEZzxAXDV/KJyLGscB5Y/I2xVLuZOKSBMeMk=;
        b=A3o06lU6rPxLb3ArsXxLUWSxjHMSomOKQbkX8YI4dq95v2DyPnideJti7G/PJNaunU
         kkoe9nrMpGpx8GtGHDfgtta9oxzB2daidIYwc/YP/2S4vhZcRVxNaSjG/qWiRy3F2cuT
         iWtLvSPGkYuXUqU3YIo6u1kQp2psYFCGPJWYKrcfeeSZA4YjdwDtLQP87sWuDX3giAHI
         6RGi1opxMM/UgJLquPSh5eHe3c1zmQYG1ex2ikWfHwZd4axh6LqoQ2qlWYjNJ5neTuM2
         x4z8MTCVMmpQ6I26lbI+BdA+Jkv4febNq3LF1YgwCKp8PRanNakeCOKbaEKwebnoB/wN
         4GJw==
X-Forwarded-Encrypted: i=1; AJvYcCUwpDzspvWAIYIOscLrdMne2OBQxBdUuVPjFyoeUsS2gQ2omVc09gB5KEL9F7/gFEJh2zIjEYp+2r3U5tsx0mg0Pbv+PP69+A==
X-Gm-Message-State: AOJu0YxOqd9Q2ubcIBw9smgRwcB+1opyDhU4UK1Sv7JWMeLatz4MbFaP
	ruBr0bKaljoF/JbHG03LqPZXdebx8ktQT0bQqjEVFqkxykBNBOd3/TctLVoAOshE3VEBjkFGf02
	rt0+Zsz15o+VzzV9naKKPOMexAH6AdNK0YGF2QiDFPGLEc9YNUS29/TYHXsyApl/oLg==
X-Received: by 2002:a05:6a20:4f9c:b0:1a0:dfd8:f759 with SMTP id gh28-20020a056a204f9c00b001a0dfd8f759mr882207pzb.21.1709005259670;
        Mon, 26 Feb 2024 19:40:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpOP2F6KeNIvC8WNJgCKq3+O/4+MaxljFKMw/g0wvT+Tr6ShI9uShsiYboiN39HwuQ3f7kYA==
X-Received: by 2002:a05:6a20:4f9c:b0:1a0:dfd8:f759 with SMTP id gh28-20020a056a204f9c00b001a0dfd8f759mr882197pzb.21.1709005259277;
        Mon, 26 Feb 2024 19:40:59 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902728500b001da34166cd2sm423776pll.180.2024.02.26.19.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 19:40:58 -0800 (PST)
Date: Tue, 27 Feb 2024 11:40:55 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: David Sterba <dsterba@suse.cz>, fstests@vger.kernel.org
Subject: Re: Dangerous commands (was:[ANNOUNCE] fstests: for-next branch
 updated to v2024.02.04)
Message-ID: <20240227034055.bqy5dzmdeu3w2zwz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240221140951.GJ355@suse.cz>
 <20240221161358.GM6188@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221161358.GM6188@frogsfrogsfrogs>

On Wed, Feb 21, 2024 at 08:13:58AM -0800, Darrick J. Wong wrote:
> On Wed, Feb 21, 2024 at 03:09:51PM +0100, David Sterba wrote:
> > Hi,
> > 
> > reading [1] and how late it was found that effectively a "rm -rf /" can
> > happen makes me worried about what I can expect from fstests after git
> > pull. Many people contribute and the number for custom _cleanup()
> > functions with unquoted 'rm' commands is just asking for more problems.
> > 
> > [1] https://lore.kernel.org/all/20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> > 
> > Unquoted arguments in shell scripts is IMO a big anti-pattern,
> 
> That wasn't even the problem there.  I temporarily forgot my shellfu and
> did the equivalent of:
> 
> <never set FUBAR>
> 
> rm -rf "$FUBAR"*
> 
> The shell helpfully expands the never-set FUBAR to an empty string, then
> globs the star to everything in the current directory.  rm has
> safeguards to prevent you from "rm -rf /" but that offers no protection
> from what happens above.
> 
> The argument was quoted "properly", but what I think you're really
> asking for is "set -u":
> 
> #!/bin/bash -u
> 
> unset FUBAR
> echo -- rm -f "$FUBAR"*
> 
> $ /tmp/a.sh
> /tmp/a.sh: line 8: FUBAR: unbound variable
> 
> Unfortunately you can't just set that unconditionally for all of fstests
> and call it a day because now you have to test every line of shellcode
> to make sure nothing breaks on unset variables that would have been fine
> otherwise.  That turns into a mess of:
> 
> test -n "$FUBAR" && rm -f "$FUBAR"*
> 
> Oh but then there's the other bad shell habit of setting variables to
> the empty string -- sometimes you really want that empty string, other
> times authors seem to have used that in place of unset.  We've gotten
> away with that bit of bad hygiene for ages, likely due to -u being a
> nondefault option.
> 
> > unfortunately present everywhere in xfstests since the beginning.
> > Rewriting all scripts would be quite a lot of work, could you at least
> > provide safe versions of the cleanup helpers?
> 
> I worried about this a long time ago, and tried running shellcheck on
> the entire codebase.  Thousands of error messages about sloppy quoting
> later I gave up.  Later I turned that into a patch in djwong-wtf that
> runs it only on the files changed by the head commit.
> 
> It **didn't notice** the cleanup error!  So that wouldn't have saved me.
> 
> Long term we ought to rewrite fstests in any language that isn't as much
> of a foot gun.  Or someone starts a project to set -e -u and deals with
> the massive treewide change that's going to be.

I think the "set -e" isn't suitable for fstests, it might bring in more
troubles. About the "set -u", it's a good idea, but as I said in another
reply, I think we need to evaluate its effection on fstests running, especially
if we want to do it at the beginning of each case. There're too many
cases in fstests, I don't know if some cases keep running with empty
variables. What do you think?

> 
> > For example:
> > 
> > _rm_tmp() {
> >     rm -rf -- $tmp
> 
> Um, isn't this /also/ an unquoted variable?
> 
> I guess one could make safe(r) wrappers so at least rm won't get mixed
> up by dashes at the start of filenames:
> 
> _rm_files() {
> 	rm -f -- "$@"
> }
> 
> _rm_dirtree() {
> 	rm -r -- "$@"
> }
> 
> But then you do
> 
> moopath="foo bar"
> _rm_files $moopath
> 
> and we've lost the battle yet again.
> 
> (On the plus side, that's four separate "f*king bash" invocations in one
> email! :))

The cleanup things need more improvement/enhancement, we can't perfect it
in one patchset, so feel free to improve it bit by bit.

> 
> --D
> 
> > }
> > 
> > and used as
> > 
> > _cleanup() {
> >     _rm_tmp
> > }
> > 
> > or at least mandate the "--" separator and quoting arguments in new code
> > and gradually fix the existing code.
> > 
> > I can send patches at least for btrfs and generic as this affects me but
> > first I'd like to know that this will become standard coding style
> > requirement in fstests.
> > 
> 

