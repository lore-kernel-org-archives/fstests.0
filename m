Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65BF37F30C
	for <fstests@vger.kernel.org>; Mon, 14 Sep 2026 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409992; cv=none; b=BViYS3H5LtVUz8pC9PoS2hDHWsJ/pPwJa1MbGE3YHpeW2qzI7CH2dO1/YuuizO52425arsd3c/IQGZPtV+fBgt5mez+1eGyKzqvpOr62Y7bf7h8Py23p7OkypiNkNd4JI+ThLY6mci49nR9crqqjRrurqxX0m19dc0oFPJp5Mxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409992; c=relaxed/simple;
	bh=9vRFy10vhi/XdDBjAHxCc2LqZd5mtar8VbIvIkTzV+4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CNK9Q9T00GfEMUO+SlistOWnAf8RZKwDjU18lGswMnRibOa7aUgFyxDHx8IKtwQ2cPW3N8xVsZwBil+m41oaGEO+oXyaDQmtFJM+TuYhOjDKejbL+VfCiUTnRelIxa8ZnFOYCNuJTsDnQ3CPrsO6OFpUimR41hVrsvhhmp0li6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=qIo7430h; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="qIo7430h"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8706dfdcd4fso35799577b3.3
        for <fstests@vger.kernel.org>; Mon, 14 Sep 2026 11:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789409989; x=1790014789; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9vRFy10vhi/XdDBjAHxCc2LqZd5mtar8VbIvIkTzV+4=;
        b=qIo7430hpICL5KWje8lhFHASW7M1hQ/TuHmv0IxhpgQ8gpPYkAu9k7WJnS+RZPLVNU
         BQOST/nbenOshuMpNHzgpfszefkg76dzlFRBZWHBrwHSCkzUf3GHhh7Gm5TIn8dlBNy0
         TMroOC9XjtqlosaE55j7ornfPYxfrgO4pB6MqLDO4yWn3HqMQbzlDjLpIt7YcN+z7qyj
         VuLgIXEk1RWnRc/uQv7FyTCOZemMW/UecMGiNpQGqYUgl+OC75cIRmzmZ/wPpZhOzwYs
         6fbLWjEV+Gj8GLaqQUzMSzFXt5WCPEhmzNMZZAGuCyPCTnC7kdRdKsvnYijWh8tcbCcg
         YU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789409989; x=1790014789;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9vRFy10vhi/XdDBjAHxCc2LqZd5mtar8VbIvIkTzV+4=;
        b=CmcPcZUOGnqB2yXwNOxNvIWzytzzv3bkSmvQNcgB1tgr0HghXZQsJTG4yrKAVAnwuh
         cOGVwv8gljA4qRKTcMMSywQoX6E9LXQrzGwYLBVlhtDid+L8CkETlHWIRMJtREwY0x7n
         F8blz5Qjbr8gMzZqY3FnWe2BldqH4zVmcA270abXWtC6Oc20rTBaNi3sqwvcmmdb+ynA
         Jt2sscvGcHNcd1wJilNtlEMrmUMiob8mbexsCe2esaqNsD874KDOIZGEQ7/NSVmj4CyT
         Op8k98IhIO45c5nLvfWQIOCOzzi1A+DfJxyM7r0NBhPnSgqYJcXzQ8MjIWfXrYXKtLi7
         jGgw==
X-Forwarded-Encrypted: i=1; AKwUvBzhJKFJCpIwHOR0XdZEB7xhXDyNFE3dW4OcZhgrLFod90BxZi4rDcKy1mBkSrJxOx8W6yvhH09j@vger.kernel.org
X-Gm-Message-State: AFuF++mJ24wuv+h8OicIXhQTslimeNeiLAlAdnRyzA9LHQSlaSih1gMH
	IAkqEDO8PUTlABYjUAS4JA7C4pJ1Vu+i3isjwTZRpeT+Rn4UJPTUcMfv2gE8V01AF/0=
X-Gm-Gg: AYBFou2MsD99VGGN+lFCoZvTJclh0oGVf5Uljo9YScMV9X6xAjp5nipzP/yo/YpeW0U
	wPenGQ3MCM3nc9/sGhEQ9Th290kkM7F7R718XovtbFQyiqczTsZhrYPw2aTbiS55B0Klu0IKNGy
	NP7fHmuOeUPU2/ovmKuiy7qqKlbRm9zRCU+KtHXpj+xTh/m4gl2yGCgFd8ibxt5rzZtKhNg0muG
	RvDyi4oqJMALC4edSRwBhtjAaJKqecXcCicj+/yrRg5Gx2r3hEUB/84QJkiKzwau/obhHH4bpIQ
	RlSMYbMsMHezfCpoq7u37K55THBADx2CnlISeOBUbwKm9/0m3Jhuwgd6I9EUN46A/GLoQ8psqKh
	DLJG1fYGTED5wmFq/Jo13VAV/cmvAmkdBJ8hKTYzvnSX2waMPGbf3f9oKAlFBxQyC9bioBzqyst
	CQxCDp4I3Fs6wFjT9dBNAFJKtVysPtvfGFVfykHwlx/MTCIYTtdvqBc3+FjdsPFMiDcNmvkvBcN
	4eB/xi5499/buucxyc4MaV/598NaPCnodnVv/v72KvoqsvjoypzLY/MW3c6U4trj97MIfFSVLH3
	+Q6UJ9kcFT652knBGudsgKXqAMAV
X-Received: by 2002:a05:690c:438c:b0:873:ea3b:6c08 with SMTP id 00721157ae682-88d1ec2e3d7mr10453187b3.1.1789409989625;
        Mon, 14 Sep 2026 11:19:49 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:df87:8743:655b:3824])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88486c2df1csm39738207b3.19.2026.09.14.11.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 11:19:48 -0700 (PDT)
Message-ID: <a2befb662989f330c9128a60b3d6dc1f35b1a79f.camel@dubeyko.com>
Subject: Re: [PATCH] xfstests: exclude hfs/hfsplus from generic/339 run
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: zlang@kernel.org, fstests@vger.kernel.org, glaubitz@physik.fu-berlin.de,
 	vdubeyko@coreweave.com, linux-fsdevel@vger.kernel.org, frank.li@vivo.com
Date: Mon, 14 Sep 2026 11:19:47 -0700
In-Reply-To: <aqOpHAoHDRzHe9UL@infradead.org>
References: <20260910000449.747189-2-slava@dubeyko.com>
	 <aqJ--AqubS-CWiV-@infradead.org>
	 <730a395bb6eed86bdff7eb21668f4f1fb42f664f.camel@dubeyko.com>
	 <aqOpHAoHDRzHe9UL@infradead.org>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-09-11 at 00:09 -0700, Christoph Hellwig wrote:
> On Thu, Sep 10, 2026 at 01:13:12PM -0700, Viacheslav Dubeyko wrote:
> > On Thu, 2026-09-10 at 02:57 -0700, Christoph Hellwig wrote:
> > > On Wed, Sep 09, 2026 at 05:04:50PM -0700, Viacheslav Dubeyko
> > > wrote:
> > > > The dirhash_collide generates filenames from arbitrary random
> > > > bytes (only '.' and '/' are filtered out), which are not valid
> > > > UTF-8 in general. Catalog names on both classic HFS and HFS+
> > > > are
> > > > Unicode. Feeding random bytes causes fsck to report "Illegal
> > > > name"
> > > > or catalog corruption that has nothing to do with directory
> > > > hash-collision handling, which is what this test is actually
> > > > meant
> > > > to exercise.
> > >=20
> > > If user file name creation manage to trigger fsck complaints, you
> > > need
> > > to righten the input checks in the file systems first to fix
> > > this.
> > >=20
> > > We can then find a programmatic way to deal with these rejects in
> > > xfstests, as ext4/f2fs in case insensiive mode probably have the
> > > same
> > > issue.
> >=20
> > I see your point. And I really like your suggestion. But what is
> > your
> > vision of the proper way to check the validity of Unicode symbols?
>=20
> I don't think validity of a unicode symbol matter directly here.=C2=A0 Yo=
u
> need to check what the Apple implementation accepts and/or what
> Apple documents and follow that.

You are right. After taking a look into hfsprogs source code [1], I
think that there is a missing piece of functionality in HFS+ kernel
driver implementation. So, let me double check that I am right and I
can fix the issue on kernel side.

By the way, have you had the chance to take a look into HFS+ iomap
patchset? Do you see any issues there? If no, then I can switch on HFS
iomap implementation. I need to share v4 of the patch because I've made
the fixes for generic/363 test-case.

Thanks,
Slava.

[1] https://salsa.debian.org/debian/hfsprogs.git
