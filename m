Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889AD1EB195
	for <fstests@vger.kernel.org>; Sun,  2 Mar 2025 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740940996; cv=none; b=LRDacK5NqG+QwhQTGyzxK8S5dxliMuqhyBGXkm3HHXqmWVzHS2dCEyA459aWkAbp0C78gnkKSW1YCeD7c803+u0gMfo+2m9/aoJqrYT/evbK8mgr8texvl4hZ75pxs9QDyKxixF0g1Sbr4HKJcm+3SYaidIacYx00psTx87AkE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740940996; c=relaxed/simple;
	bh=kr6+ULKNxwofH/oellVjBm4hazzdRmNvf53wLk6U/Zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mc/SUl+dXBxvo9no3ZvrC4lthThY6UqbJWYX+lhhOk8BCqZa+B4PwxC8Fs+SDqidNiNv4rvt4Yh80QWG1ZIYYWp6eIdCBAiFEuCOUnLG4j0zjZYN51/plHGQPOJ5Zb2+1c/4l5Yu5H07+a9cp5lBZm9hMKtPzx0uWmDACvFy/cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVLEdmtZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVLEdmtZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9E3C4CEEC
	for <fstests@vger.kernel.org>; Sun,  2 Mar 2025 18:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740940994;
	bh=kr6+ULKNxwofH/oellVjBm4hazzdRmNvf53wLk6U/Zw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rVLEdmtZ2Mo5fpVfQyZG/E3k0MfQR4m6+y+ofL1fKa0fs0WGgMZiLk34cM8NsAGTQ
	 4Yv0QtdGtycZ6hAdJ++Jj+H7MKBNb1ppi+77Nr5GBpDnxwBI4MbU5mbuD6+U6QqbGu
	 Bx6Dl2dTurlUZIlAvjFP51vhE+PNcOug8JDBaXK+EeXsMhWKm5kf9K5YyWCCvrk1QM
	 2fLFfd4KYZKLkaEDHzyEHclvLnN8SAsHpFQrB+4ZiG7Uxa6xolAxYMX5Cc0GcQ/USw
	 nln+XCKMHeLPmo4CSZq88SFoLy+8HNiq47AgLOKM6abwTL8SYNzPeORZK9FvifDg/w
	 9RcncNDOk2eJg==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abf5358984bso186399166b.3
        for <fstests@vger.kernel.org>; Sun, 02 Mar 2025 10:43:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLii4kOpigJrwQhs6dFkGfucu0vp4sR5HkuKU+/7FhEl2xeNqKBgEs5O+JwqncnUML0Vry3auK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+cL4PsPELK6e9/4SW2hB6T7gm4MvW48AHnKIhFRpi6jxxmItp
	MK3Cf6ojxSGy4+IggGtloQ/GKxyWwb/EwCNZWMCh3I+7FShTTGq6z58P+VtRPZCk3RUtRYN/R0a
	ISUV9McdGYdOYJnt3e1TLe277GeU=
X-Google-Smtp-Source: AGHT+IGUlZ8gcsRNDSoGTqWXTil+Mypk3TAg82CBIiC8IdvUOlG3QNg7BEuWp9vgEvK5yevn44ihkK64TDspTEtDszI=
X-Received: by 2002:a17:907:97cf:b0:abf:38a:6498 with SMTP id
 a640c23a62f3a-abf26708c88mr1386595766b.55.1740940993432; Sun, 02 Mar 2025
 10:43:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c238e76631b086db592f214beaa6fd94@kernel.org> <20250228123354.GE5777@twin.jikos.cz>
 <20250301140854.dplxboc3ml52e3ll@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H6Bb+pFjo11X3LAvtrVJLit1RTSg63k+weFDKsHOuYnOw@mail.gmail.com> <20250302145016.GA153209@mit.edu>
In-Reply-To: <20250302145016.GA153209@mit.edu>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 2 Mar 2025 18:42:36 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7GaFpge3zqGwB_nfL2R_Xz088zecZT0AB4VxYs5tAk=Q@mail.gmail.com>
X-Gm-Features: AQ5f1JqKrSsI1XY3AKR3jJ0-pmHceCGPEo6tEaKoHvSOJbGKtXCIh3MWjabQUAQ
Message-ID: <CAL3q7H7GaFpge3zqGwB_nfL2R_Xz088zecZT0AB4VxYs5tAk=Q@mail.gmail.com>
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Zorro Lang <zlang@redhat.com>, David Sterba <dsterba@suse.cz>, 
	"Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 2:50=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Sun, Mar 02, 2025 at 01:13:43PM +0000, Filipe Manana wrote:
> > Or another example, a fix from Ted, for a generic test case that
> > always failed on ext4:
> >
> > https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=3D=
for-next&id=3D023070744cef1fde8a5b4fbd8fa134cd5098843e
> >
>
> Actually, this fixed a bug which affected file systems for all file
> systems *except* xfs, since the generic bug was injecting an
> XFS-specific mkfs option into _scratch_mkfs.

No, it didn't affect btrfs, because -L exists for mkfs.btrfs and it's
used to set a label, which makes the test run fine.

> This was a *really*
> obvious bug, but the problem was that commit 000813899afb ("fstests:
> scale some tests for high CPU count sanity") made *huge* number of
> changes, which made it hard to review the change, and also made it
> harder for Dave to rebase the change, which is why, apparently,
> pressure was applied to merge commit 000813899afb right before Dave
> diappeared on vacation for a month.  This is why I nated that there
> appeared to be a double standarrd in place; I can't help but suspect
> that if anyone *else* had sent in this commit, it would have been
> rejected.
>
> As far as testing, my understanding is that the huge amount of testing
> happens between the promotion from for-next to the master branch.

Probably so, because I have the feeling that most of the time there's
no testing for btrfs (and it seems ext4 too) when for-next is updated.

> This is why I used to make a point of upgrading my test appliance to
> for-next, so I could help point out problems before most other
> deveopers would see it in the master branch.
>
> The fixes that you pointed out was all reasons why the master branch
> hadn't been updated in months; it was because for-next still had
> breakages.  There is the challenge that when master hasn't gotten
> updated for 2 or 3 months, it becomes harder to tell whether a test
> failure was caused by a test bug, or a kernel bug.  (It's not
> impossible; for a while I was going to older versions of for-next, and
> the comparing the results to newer versions of for-next, and then
> filtering out new tests, but it's a bit of a pain.)
>
> Ultimately, like most engineering tradeoffs this was a pain allocation
> exercise.  Dave didn't want to deal with rebasing changes, so the
> check-parallel changes got merged to for-next early.  This inflicted
> pain on other xfstests developers.
>
>                                         - Ted
