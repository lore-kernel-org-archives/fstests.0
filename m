Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4695712B71
	for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708875440; cv=none; b=maFrWHC/Txd0r2ip1hscWMDKz0umuCxwe3UNvk/iw0et1qPHowuH27wBtWdhaIKFl+4T31EsUsnKSLDgvSskMOhFrwicG7E02jIcBmMKhc9JX2zqYoxVDnKxc6pp5gztKBMFZIW4bhAshuY5kfI//kG3bksqX66hkG9E7W6eCi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708875440; c=relaxed/simple;
	bh=aRbFlIzuJjh21/rHIhJ2wZQAcmnNASZMoWe15+rlg3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqizW05GNRUGSeeky1j5q6xXpWKyo7/5N1iGq0DKJ2JN2/SdTzqmny+zGDOx6eRVeJSi6KB69XIq0xf8UEVZYrys7tF9Ihr302cq4lulONXDkqFR1kwJiRRwTVf2y/vIObMJbFtvYdLnkbfRwgstm/6TsTzRt6kNiQshg+WJi/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ElUEwgp5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ElUEwgp5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708875436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/xb9vEokF1FgsJ5miaQqRgroDp8uOqIWtj5d/oEVZs=;
	b=ElUEwgp5vPfkd+4KQdCtLz5KTDnQFX8isuwwhof92qCZROa2l77h/gy5AJU3ghRVqOWAKb
	KqtEv6z3u5ea6HGgTqeHyFmecScbWGpjVI1tKV5awaw8T3wVSE5Nonib60FMBqHd4vCj4n
	qfwG+/xKORmUPAdvScooMrwe/QMJD2Q=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-yOiGgm-OMimWbFXCCB-H6g-1; Sun, 25 Feb 2024 10:37:15 -0500
X-MC-Unique: yOiGgm-OMimWbFXCCB-H6g-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6e09015f862so1397810b3a.0
        for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 07:37:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708875434; x=1709480234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/xb9vEokF1FgsJ5miaQqRgroDp8uOqIWtj5d/oEVZs=;
        b=OdxRbthEe+Aor887+z8r1qnyJchbSF9krlzH69AU+7LZUVitVYAs0waSx+IC15dev4
         QUC6UN5dBZoHwqeiW/lDAg7scF2zDrBvto/Dlwek9GeZpILe1tElikuBXqig2bA20kEZ
         TbxvDQQAevxFiAIG0qoy+tHWbyUhfK4ryriBNlowjDPIvagux4uaQoFbasV8P2io1noC
         GV9a5S7+jASQq15GogdYIVvcuHl8+XQKhVcIJ41LT+v+pO8n5SSB37eZ5NSQw6cLVJEo
         aeQs83vPs56LUsvmPx8bJiAYOMwvx6CPvduglRrZoLJprMKG5A6fg+mb/dIihDGfZY4z
         AqyQ==
X-Gm-Message-State: AOJu0YyOUwlGucNj29hvmEknsDGNqa3xCWtOPd3u91YgSxFrWJ+3XBCm
	tvNrncGy1oZuMkJNF8qNW1DOBl9uB4mMFp+q8KmhjpTA7oqzMY7TkMZPXGu7Ie/9UbdCQZttBpz
	aZpv6FzGecm+TXAXIS0VQ96TXmBWZiw3DZez/d0PdiDYf9d2/pNXVOHlme1iqmS+SRQ==
X-Received: by 2002:a05:6a00:1da3:b0:6e4:fc2b:5f69 with SMTP id z35-20020a056a001da300b006e4fc2b5f69mr3161594pfw.4.1708875434039;
        Sun, 25 Feb 2024 07:37:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoGJZk0ncjKi2bYds7ZfUwjsxmX7llmb86TDC0GSXfxZor4y8LcZ3ojIWhBlrX+Ustb1zjmg==
X-Received: by 2002:a05:6a00:1da3:b0:6e4:fc2b:5f69 with SMTP id z35-20020a056a001da300b006e4fc2b5f69mr3161582pfw.4.1708875433663;
        Sun, 25 Feb 2024 07:37:13 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id du15-20020a056a002b4f00b006e4bcdcff43sm2476312pfb.78.2024.02.25.07.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 07:37:13 -0800 (PST)
Date: Sun, 25 Feb 2024 23:37:08 +0800
From: Zorro Lang <zlang@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
Subject: Re: Dangerous commands (was:[ANNOUNCE] fstests: for-next branch
 updated to v2024.02.04)
Message-ID: <20240225153708.on4zae3ju5zh3wkr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240221140951.GJ355@suse.cz>
 <ZdgWt8gz4815Nr/F@dread.disaster.area>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdgWt8gz4815Nr/F@dread.disaster.area>

On Fri, Feb 23, 2024 at 02:53:27PM +1100, Dave Chinner wrote:
> On Wed, Feb 21, 2024 at 03:09:51PM +0100, David Sterba wrote:
> > Hi,
> > 
> > reading [1] and how late it was found that effectively a "rm -rf /" can
> > happen makes me worried about what I can expect from fstests after git
> > pull. Many people contribute and the number for custom _cleanup()
> > functions with unquoted 'rm' commands is just asking for more problems.
> > 
> > [1] https://lore.kernel.org/all/20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> 
> I started down the _cleanup() path a couple of years ago and one of
> the reasons for that was getting rid of all the open coded rm
> commands that were often just plain wrong. That start was here:
> 
> https://lore.kernel.org/fstests/20220524073411.1943480-1-david@fromorbit.com/

Hi Dave,

Thanks for taking care about this issue. Sure I've waited for that patchset V2
long time, after V1 got enough RVB but you hoped to rebase and change it a bit.

If you still hope to do that, I can accept a pull request directly from you,
and I can merge your patchset in a single fstests release version, to avoid
code conflicts.

Hmm... or maybe you hope I can take that job, due to I can always rebase the
changes onto my latest local fstests (which's for next release), and fix code
conflicts locally ?

Thanks,
Zorro

> 
> But I got little interest except for one person picking at
> irrelevant details and wanting unnecessary API and naming changes
> that did nothing to really further the cleanup work.
> 
> It did seem like anyone was interested in having this code cleaned
> up and so I basically couldn't find the motivation to slog through
> hundreds of tests trying do stuff that nobody really seemed to care
> about....
> 
> Shame, this whole problem would have not existed if that work sort
> of infrastructure technical debt reduction was encouraged, and if it
> did there'd only be one line of code to change... :/
> 
> > Unquoted arguments in shell scripts is IMO a big anti-pattern,
> > unfortunately present everywhere in xfstests since the beginning.
> > Rewriting all scripts would be quite a lot of work, could you at least
> > provide safe versions of the cleanup helpers?
> > 
> > For example:
> > 
> > _rm_tmp() {
> >     rm -rf -- $tmp
> > }
> > 
> > and used as
> > 
> > _cleanup() {
> >     _rm_tmp
> > }
> >
> > I can send patches at least for btrfs and generic as this affects
> > me but first I'd like to know that this will become standard
> > coding style requirement in fstests.
> 
> I think it would adress this specific issue, but I think it doesn't
> address the bigger problem that fixing cleanup behaviour requires
> touching a couple of thousand tests. i.e.  it doesn't reduce the
> maintenance burden of this code at all.
> 
> The vast majority of cleanup functions are identical and/or
> unnecessary, so the right thing to do is to only have cleanup
> functions for tests that need them, and for those that do need to
> clean up to only have to clean up their own mess.
> 
> i.e. the test harness itself should be responsible for cleaning up
> $tmp stuff and doing stuff like returning to the correct directory
> after the test completes, not require every test to duplicate the
> same cargo-culted behaviour...
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

