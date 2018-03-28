Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752679AbeC1CMm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 27 Mar 2018 22:12:42 -0400
Date: Wed, 28 Mar 2018 10:12:40 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: Is there something wrong about the commit log of tools/nextid ?
Message-ID: <20180328021240.GM4684@dhcp12-143.nay.redhat.com>
References: <20180327101531.GL4684@dhcp12-143.nay.redhat.com>
 <20180327163226.GA11581@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327163226.GA11581@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: guaneryu@gmail.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 27, 2018 at 09:32:26AM -0700, Darrick J. Wong wrote:
> On Tue, Mar 27, 2018 at 06:15:31PM +0800, Zorro Lang wrote:
> > Hi,
> > 
> > Recently I always find this message when I do:
> > 
> > # git status
> > On branch master                               
> > Your branch is up-to-date with 'origin/master'.                                                
> > 
> > Changes not staged for commit:                 
> >   (use "git add <file>..." to update what will be committed)                                   
> >   (use "git checkout -- <file>..." to discard changes in working directory)                    
> > 
> >         typechange: tools/nextid
> > 
> > Even git pull to latest commit, this problem is still there.
> > If I did `git blame tools/nextid`, I can't see the commit message
> > about this file. If I did `git checkout -- tools/nextid`, then
> > `git blame tools/nextid` shows:
> > 
> >   208422233 (Darrick J. Wong 2015-12-21 18:07:52 +1100 1) sort-group
> > 
> > Only this one line. I don't know what happened to this file, is there
> > something wrong when merge or push it?
> 
> It's supposed to be a symbolic link, hence the one-line git blame after
> you git checkout.

Thanks, yes, I notice that it's a symbolic link now. I just don't know why
I need to do git checkout after a normal git pull. I didn't change anything
before git pull.

Anyway, I can't reproduce this issue after git checkout that file. If no
one hit this issue too, please ignore my issue :)

Thanks again,
Zorro

> 
> --D
> 
> > Thanks,
> > Zorro
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
