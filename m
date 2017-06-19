Received: from mx1.redhat.com ([209.132.183.28]:36626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753580AbdFSK0C (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 19 Jun 2017 06:26:02 -0400
Date: Mon, 19 Jun 2017 18:25:57 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [xfstests PATCH] overlay: test whiteout check in impure dir
Message-ID: <20170619102557.GA28689@eguan.usersys.redhat.com>
References: <1497844419-23824-1-git-send-email-yi.zhang@huawei.com>
 <CAOQ4uxgKAnLBnjF2ynTW-iLbV9m647XhnzquV37xzkBwqG-=5Q@mail.gmail.com>
 <235c78f4-1e0f-8c76-a705-8f4f01318659@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <235c78f4-1e0f-8c76-a705-8f4f01318659@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: "zhangyi (F)" <yi.zhang@huawei.com>
Cc: Amir Goldstein <amir73il@gmail.com>, fstests <fstests@vger.kernel.org>, overlayfs <linux-unionfs@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, miaoxie@huawei.com
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 19, 2017 at 02:28:08PM +0800, zhangyi (F) wrote:
> On 2017/6/19 13:40, Amir Goldstein Wrote:
> > On Mon, Jun 19, 2017 at 6:53 AM, zhangyi (F) <yi.zhang@huawei.com> wrote: 
> >> --- a/tests/overlay/group
> >> +++ b/tests/overlay/group
> >> @@ -33,3 +33,4 @@
> >>  028 auto copyup quick
> >>  029 auto quick
> >>  030 auto quick perms
> >> +031 auto quick
> > 
> > Maybe add "whiteout"
> 
> Indeed, I missed this one. Thanks for your suggestion.

I can add it at commit time if everything works as expected (I haven't
run the test myself yet, but will do :).

Thanks,
Eryu
