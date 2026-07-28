Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D014E27467F
	for <fstests@vger.kernel.org>; Tue, 28 Jul 2026 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221368; cv=none; b=O60zQtDKN7RNpcRcXlx7DxgV36c3qlavcvJ11eFK28YnRUfM+f2E1WmI03nF6ngL1JmORshTCHszhTrTHONKAQ+9j6q5lmz7P3CABD9AQFlR0rW4Vd3v8Icf1F+PwnDRuvymLRJXsg19ycf0JyXZhUfuXNjW2yQV/UJo1a7k5EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221368; c=relaxed/simple;
	bh=1oK5DrIvwtXFuemO7wCgo7L5+Man6PI6yHMf/xhTn94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qV4ju/pq65NtwbFuJ7yjE3wb2YeYjzoJ82d6ZvNzTMFTck8zyn68e7IK5dzoVy1oUSYIJmNeffymHl/g+tSOw+0kn6Idesydt5sv8Eskv7G7RyF54DgjpDPtBumEDW4DEbxyl+ZBPiAoN/y+kJ1uXAzwaUadegUInIE96RmXm0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThvyjwIp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThvyjwIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB4B1F000E9;
	Tue, 28 Jul 2026 06:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785221366;
	bh=tlfKZiyYkrkM7p7iQu/UMLwgod3tcR5QMt0gjlecmY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ThvyjwIpwAtUlNyN9OwobltIqW9264KDgSHPy844jH4j1oENNIeMmkw8dJPWDRmIm
	 vMFE57babQhn1eic5iupYG8t3Ox8owxx5JeRqFudQbUZ9qNZu1DxHcPsmXPAj4TfWL
	 72pt9YeqFH//NEmsAibg8rQoURl6RzSVkbASBIIh5Hfo+f676w/qDdLpqd1C5i5xva
	 /OVr6SzxotvJ8qQVAkyRBJ2Mo5Vn/lAKdEmXbMIUMLWafEXDdmV+I1W1RcHs9Z0qlE
	 0J3aN+v4K3tKJN5UhKAPBV4Ilb4Z9idNKvEzxIPDi393vmBYfHLDiUZ0IuOGqJWMf0
	 NXNLWxzoCwcTQ==
Date: Tue, 28 Jul 2026 14:49:19 +0800
From: Zorro Lang <zlang@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Anand Suveer Jain <asj@kernel.org>, fstests@vger.kernel.org, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2] common/rc: support f2fs in
 _require_fanotify_ioerrors()
Message-ID: <amhKovVDjwawoWdQ@zlang-mailbox>
Mail-Followup-To: Chao Yu <chao@kernel.org>, 
	Anand Suveer Jain <asj@kernel.org>, fstests@vger.kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, "Darrick J. Wong" <djwong@kernel.org>
References: <20260706064326.3657995-1-chao@kernel.org>
 <af5f0eb1-0197-4952-a37b-0602799929ec@kernel.org>
 <5c11cd98-bb41-46e0-9765-e2aad57a08e4@kernel.org>
 <aloCfjjqesxpzL9z@zlang-mailbox>
 <a081f7cf-bd47-459d-baee-de772d816af4@kernel.org>
 <ameajJf8iiAQYWA3@zlang-mailbox>
 <99220f8b-05d4-427f-998d-7f15a84c8805@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99220f8b-05d4-427f-998d-7f15a84c8805@kernel.org>

On Tue, Jul 28, 2026 at 10:24:10AM +0800, Chao Yu wrote:
> On 7/28/26 01:57, Zorro Lang wrote:
> > On Thu, Jul 23, 2026 at 05:09:12PM +0800, Chao Yu wrote:
> > > On 7/17/26 18:47, Zorro Lang wrote:
> > > > On Wed, Jul 08, 2026 at 11:25:37AM +0800, Chao Yu wrote:
> > > > > On 7/7/26 18:13, Anand Suveer Jain wrote:
> > > > > > On 6/7/26 14:43, Chao Yu wrote:
> > > > > > > f2fs has supported to report fserror, this patch adds support for f2fs
> > > > > > > in _require_fanotify_ioerrors(), so that we can run generic/791 on f2fs.
> > > > > > > 
> > > > > > > Cc: Darrick J. Wong <djwong@kernel.org>
> > > > > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > > > > ---
> > > > > > >   common/rc | 3 +++
> > > > > > >   1 file changed, 3 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/common/rc b/common/rc
> > > > > > > index 494725547..f51ad59f3 100644
> > > > > > > --- a/common/rc
> > > > > > > +++ b/common/rc
> > > > > > > @@ -6257,6 +6257,9 @@ _require_fanotify_ioerrors()
> > > > > > >   		x="$(_get_fs_sysfs_attr $TEST_DEV err_report_sec)"
> > > > > > >   		test -n "$x" && return 0
> > > > > > >   		;;
> > > > > > 
> > > > > > 
> > > > > > > +	f2fs)
> > > > > > > +		x="$(cat /sys/fs/f2fs/features/fserror)"
> > > > > > > +		test -n "$x" && return 0
> > > > > > 
> > > > > > Don't we need to check if /sys/fs/f2fs/features/fserror
> > > > > > is present in the running kernel (there are helpers)
> > > > > 
> > > > > Hi Anand,
> > > > > 
> > > > > You mean _has_fs_sysfs_attr()? however, it forces to check first parameter $dev
> > > > > w/ block device type:
> > > > > 
> > > > > 	if [ ! -b "$dev" -o -z "$attr" ];then
> > > > > 		_fail "Usage: _has_fs_sysfs_attr <mounted_device> <attr>"
> > > > > 	fi
> > > > 
> > > > Hi Chao and Anand,
> > > > 
> > > > The *_fs_sysfs related helpers were brought in by me in:
> > > >    commit 2a7b77abcd1dde735186b363da24540706c43b73
> > > >    Author: Zorro Lang <zlang@redhat.com>
> > > >    Date:   Tue Jul 5 17:30:24 2016 +0800
> > > > 
> > > >      xfs: configurable behavior on errors at unmount time
> > > > 
> > > > At that time, I didn't think about the "features/" directory.
> > > > 
> > > > Now, let me rethink this set of helpers. I feel that the *_fs_sysfs
> > > > family of functions shouldn't be restricted to the $dev directory,
> > > > we should remove this restriction.
> > > > 
> > > > Following that, we bring in *_fs_sysfs_device (appending the _device suffix)
> > > > helpers which call *_fs_sysfs(). Also change the test cases who call these
> > > > functions.
> > > > 
> > > > Finally, we can introduce the *_fs_sysfs_features functions (or simply use
> > > > *_fs_sysfs directly).
> > > > 
> > > > Also, we have both *_fs_sysfs_attr and *_fs_sysfs, and the logic between
> > > > them is somewhat confusing and easy to mix up.
> > > 
> > > Zorro,
> > > 
> > > It makes sense, and good news to their user. Thanks for the proposal.
> > > 
> > > > 
> > > > I need to write a series of patches to clean up these logic. For this current
> > > > patch, we can start with a small-scale change first. What do you think?
> > > 
> > > So I will use this first:
> > > 
> > > f2fs)
> > >      local feat_file="/sys/fs/f2fs/features/fserror"
> > >      if [ -f "$feat_file" ] && [ "$(cat "$feat_file")" = "supported" ]; then
> > >          return 0
> > >      fi
> > >      ;;
> > > 
> > > And then waiting for your cleanup? or if you want to clean up this, please do it
> > > directly while merging.
> > 
> > If f2fs wants to test this feature right away, I can merge your patch now and
> > clean it up later. If it's not urgent, I'll take care of it all together.
> 
> Zorro,
> 
> Could you please help to merge it first? so that we can test 791 w/ last
> upstream code, and also in case we missed to track its status to lose it. :P

Sure, I'm good to have this first. Could you send a new patch version, if you'd
like to change it?

Thanks,
Zorro

> 
> Thanks,
> 
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > Thanks,
> > > > Zorro
> > > > 
> > > > > 
> > > > > 
> > > > > > before reading it?
> > > > > 
> > > > > How about this?
> > > > > 
> > > > > f2fs)
> > > > >      local feat_file="/sys/fs/f2fs/features/fserror"
> > > > >      if [ -f "$feat_file" ] && [ "$(cat "$feat_file")" = "supported" ]; then
> > > > >          return 0
> > > > >      fi
> > > > >      ;;
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > >   	esac
> > > > > > >   	_notrun "$FSTYP does not support fanotify ioerrors"
> > > > > > 
> > > > > 
> > > 
> > > 
> 
