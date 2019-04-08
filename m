Received: from mx1.redhat.com ([209.132.183.28]:39584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbfDHC1b (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 7 Apr 2019 22:27:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A258308FF15
        for <fstests@vger.kernel.org>; Mon,  8 Apr 2019 02:27:31 +0000 (UTC)
Date: Mon, 8 Apr 2019 10:27:29 +0800
From: Murphy Zhou <xzhou@redhat.com>
Subject: Re: [PATCH] generic/294: skip on NFS
Message-ID: <20190408022729.nacikxpupidv73ce@XZHOUW.usersys.redhat.com>
References: <20190304025008.11986-1-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304025008.11986-1-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, bcodding@redhat.com
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 04, 2019 at 10:50:08AM +0800, Murphy Zhou wrote:
> Because NFS handles this differently, returning different values.
> Details:
> http://people.redhat.com/bcodding/nfs/2016/10/07/nfs_xfstest_generic/#generic294

Any comments are helpful, :)

Thanks
M

> 
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> ---
>  tests/generic/294 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/294 b/tests/generic/294
> index b74579ac..f7e763a3 100755
> --- a/tests/generic/294
> +++ b/tests/generic/294
> @@ -27,6 +27,7 @@ _cleanup()
>  . ./common/filter
>  
>  # real QA test starts here
> +[ $FSTYP == "nfs" ] && _notrun "NFS behaves differently, breaks golden output"
>  
>  # Modify as appropriate.
>  _supported_fs generic
> -- 
> 2.21.0
> 
