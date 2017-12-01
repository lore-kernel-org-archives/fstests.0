Received: from mx1.redhat.com ([209.132.183.28]:35214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752157AbdLAEND (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 30 Nov 2017 23:13:03 -0500
Date: Fri, 1 Dec 2017 12:13:01 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] common: Add infrastructure for syncfs syscall tests
Message-ID: <20171201041301.GB2749@eguan.usersys.redhat.com>
References: <1512100554-16368-1-git-send-email-cgxu@mykernel.net>
 <621FF37E-8612-489C-8721-4BBC08BAB336@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <621FF37E-8612-489C-8721-4BBC08BAB336@mykernel.net>
Sender: fstests-owner@vger.kernel.org
To: Chengguang Xu <cgxu@mykernel.net>
Cc: Amir Goldstein <amir73il@gmail.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 01, 2017 at 12:04:44PM +0800, Chengguang Xu wrote:
> Hi Eryu,
> 
> Actually, in my another test case generic/470 will need to check whether fs supports syncfs or not. 
> I make shared infrastructure for checking that, and because it is common component 
> I post as an individual patch instead of including in the case of generic/470.

I think "_require_xfs_io_command syncfs" should be fine, there's no need
& not encouraged to add new binary & usage like this. If you want to run
syncfs(2) to make sure the kernel actually supports it, you can add a
new 'syncfs' switch case in _require_xfs_io_command.

Thanks,
Eryu
