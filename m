Received: from mail-pf1-f196.google.com ([209.85.210.196]:38161 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730578AbfIMQMj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 13 Sep 2019 12:12:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so18383488pfe.5
        for <fstests@vger.kernel.org>; Fri, 13 Sep 2019 09:12:37 -0700 (PDT)
Date: Fri, 13 Sep 2019 09:12:35 -0700
From: Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] fstests: btrfs: Verify falloc on multiple holes won't
 cause qgroup reserved data space leak
Message-ID: <20190913161234.jfkyopccbohz5njz@macbook-pro-91.dhcp.thefacebook.com>
References: <20190913015151.15076-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913015151.15076-1-wqu@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 13, 2019 at 09:51:51AM +0800, Qu Wenruo wrote:
> Add a test case where falloc is called on multiple holes with qgroup
> enabled.
> 
> This can cause qgroup reserved data space leak and false EDQUOT error
> even we're not reaching the limit.
> 
> The fix is titled:
> "btrfs: qgroup: Fix the wrong target io_tree when freeing
>  reserved data space"
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
