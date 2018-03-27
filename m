Received: from aserp2130.oracle.com ([141.146.126.79]:39364 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753665AbeC0Qcc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 27 Mar 2018 12:32:32 -0400
Date: Tue, 27 Mar 2018 09:32:26 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: Is there something wrong about the commit log of tools/nextid ?
Message-ID: <20180327163226.GA11581@magnolia>
References: <20180327101531.GL4684@dhcp12-143.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327101531.GL4684@dhcp12-143.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: guaneryu@gmail.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 27, 2018 at 06:15:31PM +0800, Zorro Lang wrote:
> Hi,
> 
> Recently I always find this message when I do:
> 
> # git status
> On branch master                               
> Your branch is up-to-date with 'origin/master'.                                                
> 
> Changes not staged for commit:                 
>   (use "git add <file>..." to update what will be committed)                                   
>   (use "git checkout -- <file>..." to discard changes in working directory)                    
> 
>         typechange: tools/nextid
> 
> Even git pull to latest commit, this problem is still there.
> If I did `git blame tools/nextid`, I can't see the commit message
> about this file. If I did `git checkout -- tools/nextid`, then
> `git blame tools/nextid` shows:
> 
>   208422233 (Darrick J. Wong 2015-12-21 18:07:52 +1100 1) sort-group
> 
> Only this one line. I don't know what happened to this file, is there
> something wrong when merge or push it?

It's supposed to be a symbolic link, hence the one-line git blame after
you git checkout.

--D

> Thanks,
> Zorro
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
