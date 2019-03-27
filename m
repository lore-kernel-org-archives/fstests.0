Received: from mail-qt1-f176.google.com ([209.85.160.176]:43309 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfC0O3t (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Mar 2019 10:29:49 -0400
Received: by mail-qt1-f176.google.com with SMTP id v32so19009455qtc.10
        for <fstests@vger.kernel.org>; Wed, 27 Mar 2019 07:29:48 -0700 (PDT)
Date: Wed, 27 Mar 2019 10:29:46 -0400
From: Josef Bacik <josef@toxicpanda.com>
Subject: Re: Is log-writes project still maintained or the one in fstests is
 the official tool?
Message-ID: <20190327142945.uulyrqdvdaaem532@MacBook-Pro-91.local>
References: <151f1161-a338-37dd-8e65-26fc5fd45f8d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151f1161-a338-37dd-8e65-26fc5fd45f8d@suse.de>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.de>
Cc: fstests <fstests@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 27, 2019 at 03:53:59PM +0800, Qu Wenruo wrote:
> Hi,
> 
> Is the log-writes tool in fstests/src the latest and maintain version?
> 
> The one in Josef's github hasn't been updated for over one year, and it
> seems the output from fstests is different from Josef's.
> 
> I'm wondering for new patches where should they go?
> 

Send patches to the fstests one, that's what everybody uses.  My github was just
a staging area until it got accepted into fstests.  I still use mine, but it's a
simple tool, just because it hasn't been changed doesn't mean it doesn't get
used.  Thanks,

Josef
