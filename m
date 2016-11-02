Received: from mx1.redhat.com ([209.132.183.28]:37656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752656AbcKBKg6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 2 Nov 2016 06:36:58 -0400
Date: Wed, 2 Nov 2016 18:36:56 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic: create and delete files repeatedly to exercise
 ENOSPC behaviour
Message-ID: <20161102103655.GW27776@eguan.usersys.redhat.com>
References: <1477999170-20026-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
 <20161101122613.GR27776@eguan.usersys.redhat.com>
 <5819BE82.10205@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5819BE82.10205@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 02, 2016 at 06:22:58PM +0800, Wang Xiaoguang wrote:
> hi Eryu,
> 
> There has already be a generic/102 doing this test...
> Thanks for you kindly review and sorry for wasting your time.

I had impression yesterday that we have a case that does exactly the
same test, and I searched but didn't find it.. It turns out that we do
have it already :)

Thanks for writing new test cases!

Eryu
