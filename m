Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EFC1C84BC
	for <fstests@vger.kernel.org>; Wed,  8 Jul 2026 06:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783490635; cv=none; b=s9Bfigcua+0Z1wLHrU0jGdADA9aCCsCQX7CfffHA/6rKtsf80CSlcy6GLUQORUa0PUdNB/+z3NZUzgcUU117ZwtZ17dK3XIrY9l59WAVTqf0ihT3HNJ3KN4jF2EJEfmtNIcjt/Bllf07aEHXBPE5IT7QBHoJaSHqrZb40iygA3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783490635; c=relaxed/simple;
	bh=SE17FbBoVQ1aBd0sLy0Yl/aIciE75LaYX1FJWbocc1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+DvhgerZBMS5IqAO+VFQlNycqt3WKNW4/oYyz5IUZm8RmvDkrQatUm0/edAbMMArxux9A/WSLORhEiMtdbxPQi/MKExhyzYErpYF6rTLekH9txrIqwI9nWU5pTCagjazCaPwIuqO+WgABhADJE+RmLIJLPXGeUBRVUK1Tkty08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGcFJCVR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGcFJCVR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09E51F000E9;
	Wed,  8 Jul 2026 06:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783490634;
	bh=llkLKsOR9PknoEgDWcnrGWfV30HkU1bLr89lbeUvfJY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gGcFJCVRcR5EzSNtHGS9CBvLKRUnkJbPoC7EsjgwU+EryVB4Ys3tKrTmPZOBKYzLW
	 KB8oXfUqcH9nR8dDVvr4X6rLpOSOsC/+EJrQJFySWUEKKPQ227oIljD6P4Vt1vud+5
	 GRbOfQJJYC6iqk44OghzPzM3j5pqxp41nP4WJEvE1Z9LH4UDUW+0/mqgOE8fOIbfEx
	 zQfD3BOcMsCBo4IN2HVPqnAji5BgHUlDNHpu4TjL3ar4v6B6GuVM20GYFpaKmd2u7Q
	 drgA4dMDW2f4klH6t0r51RtXNJH/P14G7QzMJbwhrYdt5Xddlgkg7s6cKWOJvajaPQ
	 /ofD0r8G1ReRw==
Message-ID: <e19e5b1b-ba0a-463b-8bde-c9f31f4e961b@kernel.org>
Date: Wed, 8 Jul 2026 14:03:50 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] common/rc: support f2fs in
 _require_fanotify_ioerrors()
To: Chao Yu <chao@kernel.org>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 "Darrick J. Wong" <djwong@kernel.org>
References: <20260706064326.3657995-1-chao@kernel.org>
 <af5f0eb1-0197-4952-a37b-0602799929ec@kernel.org>
 <5c11cd98-bb41-46e0-9765-e2aad57a08e4@kernel.org>
Content-Language: en-US
From: Anand Suveer Jain <asj@kernel.org>
In-Reply-To: <5c11cd98-bb41-46e0-9765-e2aad57a08e4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



> How about this?
> 
> f2fs)
>     local feat_file="/sys/fs/f2fs/features/fserror"
>     if [ -f "$feat_file" ] && [ "$(cat "$feat_file")" = "supported" ]; then
>         return 0
>     fi
>     ;;


This is a check we will use often.
Why not add a helper like the untested code below [1]?
Furthermore, I can clean up _require_btrfs_fs_feature()
to use [1] as well.


[1]
common/rc:

_require_fs_feature_attr()
{
	local feat="$1"
	local attr="$2"

	modprobe $FSTYP > /dev/null 2>&1

	[ -e /sys/fs/$FSTYP/features/$feat ] || \
		_notrun "Feature $feat not supported on $FSTYP"

	if [ -n "$attr" ]; then
		if ! grep -qw "$attr" /sys/fs/$FSTYP/features/$feat; then
			_notrun "Feature $feat attribute $attr missing"
		fi
	fi
}

