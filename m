Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF430482E4
	for <fstests@vger.kernel.org>; Fri, 22 Mar 2024 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120084; cv=none; b=tymQo5aXbcQB5z1HSe1aGXDRxaqlQ1ckdev1IpKC1rITPeRRFswVbTnqYVnJ+3aOxnSnM9rH37Bwgb7v/BXQ1Km+FALWs0e7mBHd/OC4nHElrjL19ZSr7j7wOH0GV6fqdby70m4KQjTrPYjTtPuUG+jXu1bNEeH9bbDCWTgG1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120084; c=relaxed/simple;
	bh=ANUEjgGmjFfiyPnielm2iA1mg4fSjHypCoqLFITPHmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noR6bs0NFBkNCVp+IxtSxFFeSu2bidyzTZmZmLufGwodcBwKfszLWBKgVZvHDuzt3h88KnmwAx9gpufdNVONUyFoyG1RGyrGEqE19kEwkSm1p9SXGPmCmybyN7KhYn5ryA95FV6aZx/F+thQ+Ht+juyMPPelHl1XKjdEQi1llJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=kWNLlFac; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="kWNLlFac"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-430bf84977dso15842081cf.1
        for <fstests@vger.kernel.org>; Fri, 22 Mar 2024 08:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1711120081; x=1711724881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z33ZkYULW9jugkQGXTQwsjj4Ak78sO0aSSF/mjtJqD8=;
        b=kWNLlFacpoNg9IWznuLZBPHOHJPIEgyz66lr+UXafLtb21qv00OSkjZkl7fXxHK/gb
         C4VnFV8mi+tiNfGnw3cMfp/4mbaZDgoFyZCdI3mO24xMpoI1guHF2o1rnaUjaYWUIyOW
         enUE2R3hhsslodnirV4lodc5R2x4AuRVwmAGtLfM1L4UXJRFpLwpDcRwECAOzxw2OLn+
         Ox/39ATUm/+MhUMnAVc/TIR9pzZvFzv0IswPhBI1imIn3m1j3peXthBefjMdmZeYoCAI
         oMRNIxHdUe2QRUsjQTHR5R66n4XA2ZboWs6kFdBR0/0RhYeEGfQKX3n3uSOGxD8dmxEh
         +Mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120081; x=1711724881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z33ZkYULW9jugkQGXTQwsjj4Ak78sO0aSSF/mjtJqD8=;
        b=EYFgNEurZGU6gND8ee2XX2nBMEc1m7XD5LDX35p/Xg/y08BTV8hJEl6bUAdPNhjczE
         4QEisvFG46lBze3ncQF4BPID+Kb1cBdkBeMmVaGkgLZUQrhzLhO41UJoBQl8Itf4LgEE
         7t87X5YQEDD93XURdlRCWT8hOYpDJuojN5hupKpe4AIJP7mJ45bwxHeOvV1hUkhKtKGQ
         ByYdnXl7JTRcQHhrf8Fcf/M1oSnWn/+wYVsk0qqhpRJV3FnT6Rlzqq5OKNI+y+v7Sl2F
         nJ8Nme0V/wgkQf68G0E+7B6xGC9LXe+hRRuEW/FWaKnU3KSdSwGEurIa3mK2FV/PF5wP
         s8Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVxgNSy/kL3VB36QzplOlDfcgqyssJwhpO0VvQTomRUheXLe7GYi+GIFvgBhiOBnDCYILu7zL6tn6TwTvUsZmPsPTnhZwWjhQ==
X-Gm-Message-State: AOJu0Yxnwx+59IBa4N6/l1wH7mYUYE+WSQQDEqwLifKpakaBEGZedbBS
	3p4nBGnyvkcbG0S0mQy1OhTiV+0X0ZVP1y+19eAPhu2Gxq2otVlWlDgQXoiQg6U=
X-Google-Smtp-Source: AGHT+IHsb/5MGPkp5ZJoTYZVXUbqC1OwT69lbJ3iApvrD6BIgcO4ElhAlKjhZyWmzu82CasZssxK2A==
X-Received: by 2002:a05:6214:501e:b0:696:75ab:ac72 with SMTP id jo30-20020a056214501e00b0069675abac72mr266857qvb.52.1711120081397;
        Fri, 22 Mar 2024 08:08:01 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a8-20020ad45c48000000b0069616c0ba52sm1144346qva.63.2024.03.22.08.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:08:00 -0700 (PDT)
Date: Fri, 22 Mar 2024 11:08:00 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>, David Sterba <dsterba@suse.cz>,
	David Sterba <dsterba@suse.com>, fstests@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 5/5] generic/733: disable for btrfs
Message-ID: <20240322150800.GB3202449@perftesting>
References: <cover.1710871719.git.dsterba@suse.com>
 <094a1bdc304b236ba41aff4da454abe3c93a355c.1710871719.git.dsterba@suse.com>
 <Zfn9DMR8UQQMiyiL@infradead.org>
 <20240320155824.GD14596@suse.cz>
 <Zfyob_7NV9Kbd9pU@infradead.org>
 <xlwjfzviowyls5wnomqzufkfr6zm6mot3rpy6ct7rwyrwixjpt@uf47gsudlhxn>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xlwjfzviowyls5wnomqzufkfr6zm6mot3rpy6ct7rwyrwixjpt@uf47gsudlhxn>

On Thu, Mar 21, 2024 at 05:52:33PM -0400, Kent Overstreet wrote:
> On Thu, Mar 21, 2024 at 02:36:47PM -0700, Christoph Hellwig wrote:
> > On Wed, Mar 20, 2024 at 04:58:24PM +0100, David Sterba wrote:
> > > It is a bug in the test, it should have been xfs specific and never
> > > promoted to generic/ and not affect btrfs unless explained how
> > > in the first place.
> > 
> > Well, the concept that reflinks are reasonably fast and are not live
> > locked by ongoing I/O seems pretty natural.  But I guess we can't
> > just asusme quality of implementation everywhere, and do an opt-in
> > like _require_non_sucky_reflink.  Either way we need to document
> > the assumptions and not add a magic exclude for a single fs.
> 
> generic/733 runs just fine on bcachefs, sounds like btrfs folks just
> need to fix their filesystem

Neither of these comments are particularly helpful or relevant to the
conversation.

Btrfs range locks the extent during the clone operation, and also range locks
the area that it reads.  This doesn't make it "sucky" or "worse", simply
different.  I'm not entirely sure why protecting a range of extents that's
currently being modified is considered "bad" or "broken".

In any case, I can accept that we need to have a different option for skipping
this test, but this is sort of an argument for the shared/ directory or some
other mechanism, or at the very least validating the test passes on all the
major file systems before including it as a generic test.

Adding an opt in _require feels like the best option, or we can simply keep
excluding it in our own fstests branch and ignore the upstream branch.  I'm good
with either solution.  Thanks,

Josef
