Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FF85220
	for <fstests@vger.kernel.org>; Mon, 19 Feb 2024 03:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708314157; cv=none; b=s/E/78dqc1iZr2YP/mQKU5ZAGS6sxQceMJgtNF6hc+Giqn8lJDG/ZefL8KxEBhGLe4tifTRGfQpOLuidkfv3nQquVoqmkkovRRY0heZanVmK6KSRZ3GKG0OQi7e30t/lthUel9dk8aVuDsU+Bs4LtTUv7uPWazz9XjY7AdymilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708314157; c=relaxed/simple;
	bh=Hu/euHj5j899YVWzN9wf612S7R2Z3CPK4e4MYBKPJa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVZR61sioATb2RYfxuMX3dxpiwDu6QM8rg65bvTHZxZcVfcDyn3lCD5eQPhNJWv4HokJFj/HpU4HgmN7wsjFTunBYwmGPuYHeDXdirpxoSkT5L5vrPbVVDS6Eq+cjFem5b96LMAGkJugCsFVm4zGyelAMoPnnUrOsM5nzPcfFVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=gvt1Zjfh; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="gvt1Zjfh"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so2892436b6e.3
        for <fstests@vger.kernel.org>; Sun, 18 Feb 2024 19:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708314155; x=1708918955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eyiPZACU0oUbgHtW/CjAbawigtEMb+yd9pHo7XpiTxc=;
        b=gvt1Zjfh/BkhzRyOHCVwRbDXyKyPx+drUq56KoK6c8jbXgHTXNF2lKIhVB37MxDOO5
         SYqzsFNAKJpbFU4S6V8EyBugOcgTPNhxYDTnTZoqFE413oLG+p+yYcXjhYjAhRy+2Gst
         sD2DkdsAzXVEtJYtQja0P6kI9fDGS7GXwydBvdZ/rM40b6ufDyiWw+Y3wdq70p3QxVjQ
         F9qzMt6zonQpccFi/1aOYwvR0wJeavHoGSAe1QtuxNiM3iGoukiZDEDIdpPALWkKeL10
         H3pBfTlvnYyG8lAVuFTTGO1v3y1ovgfxrTiTbzRZjZFfcfWkPvf+qHcIwkFBZ/eBbJr/
         Ah9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708314155; x=1708918955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyiPZACU0oUbgHtW/CjAbawigtEMb+yd9pHo7XpiTxc=;
        b=l0bAK/fM7FCS1CwmNE6Cc05Hs3UFSVKlpX0uNXOzsQkCFGJY9+k494I1x8Mq+eS2ad
         eJkazOg/tuJwU1I/6ZHMBbPI9YvchipwqeOI90/s0d1FCqPY7E9ZcNsAcJXzj7jF1edT
         GI8nrwUApsoEyglxx7Y7m/aCrU5VTOJVDwEmjlda275WI1C31XAMezoQaWwp5VSgNqwr
         fLnS/vYBh3W7/NPhW4K88eJaBb90J32llx8O/pVC6NE1pImH70htwlpVSqFX2fY/j64N
         PdpvBQWQvFVFXGQvZirNEs7syHa6nwrOxP0dgKv044Egwe9ElrAap11qez6kl3Z9Ywxv
         NhjA==
X-Gm-Message-State: AOJu0YxRx8HsSIqYO7K33Rc23J1qIsMWKJSCjpyuYBtJPdBnlbmMkd8D
	SPGGZEiRWQVxOld/l6jSJHBfj1YKEpqOvjaGnAUeLXmtwi4oxRKJaVi4UI4GGOA=
X-Google-Smtp-Source: AGHT+IG247sHaGRl0dGx31RZj3qfKm4TNVdNxXI0dcCXMIdpylbZRR4lU0I0kGWWKmP/wgjk9l782Q==
X-Received: by 2002:a05:6808:1296:b0:3c0:4653:6e9e with SMTP id a22-20020a056808129600b003c046536e9emr13956348oiw.6.1708314155496;
        Sun, 18 Feb 2024 19:42:35 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id fb39-20020a056a002da700b006e44bce8318sm1695413pfb.124.2024.02.18.19.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 19:42:35 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rbuY4-008SAI-30;
	Mon, 19 Feb 2024 14:42:32 +1100
Date: Mon, 19 Feb 2024 14:42:32 +1100
From: Dave Chinner <david@fromorbit.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: fstests@vger.kernel.org, anand.jain@oracle.com, aalbersh@redhat.com,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	kdevops@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH 3/3] check: add --print-start-done to enhance watchdogs
Message-ID: <ZdLOKCYnM3XybqQp@dread.disaster.area>
References: <20240216181859.788521-1-mcgrof@kernel.org>
 <20240216181859.788521-4-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216181859.788521-4-mcgrof@kernel.org>

On Fri, Feb 16, 2024 at 10:18:59AM -0800, Luis Chamberlain wrote:
> fstests specific watchdogs want to know when the full test suite will
> start and end. Right now the kernel ring buffer can get augmented but we
> can't know for sure if it was due to a test or some odd hardware issue
> after fstests ran. This is specially true for systems left running tests in
> loops in automation where we are not running things ourselves but rather just
> get access to kernel logs, or for filesystem runner watdogs such as the one
> in kdevops [0]. It is also often not easy to determine for sure based on
> just logs when fstests check really has completed unless we have a
> matching log of who spawned that test runner. Although we could keep track of
> this ourselves by an annotation locally on the test runner, it is useful to
> have independent tools which are not attached to the process which spawned
> check to just peak into a system and verify the system's progress with
> fstests by just using the kernel log. Keeping this in the test target kernel
> ring buffer enables these use cases.
> 
> This is useful for example for filesyste checker specific watchdogs like the
> one in kdevops so that the watchdog knows when to start hunting for crashes
> based just on the kernel ring buffer, and so it also knows when the show is
> over.

Why can't the runner that requires timing information in the
kernel log just emit a message to the kernel log before it
runs check and again immediately after completion of the check
script?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
