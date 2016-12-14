Received: from smtp2.provo.novell.com ([137.65.250.81]:41743 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752752AbcLNHz3 (ORCPT
        <rfc822;groupwise-fstests@vger.kernel.org:0:0>);
        Wed, 14 Dec 2016 02:55:29 -0500
Subject: Re: [PATCH 1/7] ocfs2: test reflinking to inline data files
References: <148149316504.31093.16129068344227450710.stgit@birch.djwong.org>
 <148149317133.31093.439907074888693999.stgit@birch.djwong.org>
 <20161212090120.GV29149@eguan.usersys.redhat.com>
 <20161212180922.GP8436@birch.djwong.org>
 <20161213032057.GE29149@eguan.usersys.redhat.com>
 <20161213071136.GB6366@birch.djwong.org>
 <20161213213540.GC6366@birch.djwong.org>
From: Eric Ren <zren@suse.com>
Message-ID: <a4a5e444-e7b5-818f-10f5-432b65dfcc89@suse.com>
Date: Wed, 14 Dec 2016 15:32:47 +0800
MIME-Version: 1.0
In-Reply-To: <20161213213540.GC6366@birch.djwong.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>, Eryu Guan <eguan@redhat.com>
Cc: ocfs2-devel@oss.oracle.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi!

On 12/14/2016 05:35 AM, Darrick J. Wong wrote:
> On Mon, Dec 12, 2016 at 11:11:36PM -0800, Darrick J. Wong wrote:
>> coreutils 8.26 (latest) doesn't have any OCFS2_IOC_REFLINK support; I
>> suspect a distro patch in the srpm or something....
> Confirmed.  SuSE's coreutils package has a patch that tries the ocfs2
> reflink ioctl and bails out of cp without trying the btrfs/vfs clone
> ioctl if the ocfs2 ioctl returns EEXIST.  I suppose that'll have to get
> fixed in their coreutils package, but until then it'll just be broken.
> :/
>
> FWIW I also confirm that none of (upstream, RHEL, OL, Debian, or Ubuntu)
> have this patch, so this shouldn't be a problem on any of them.

I'm going to fix this issue for openSUSE. Thanks for your guys' efforts!

Thanks!
Eric
>
> --D
>
>> --D
>>
>>> Thanks,
>>> Eryu
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

