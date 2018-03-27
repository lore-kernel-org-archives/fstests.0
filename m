Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751192AbeC0KPe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 27 Mar 2018 06:15:34 -0400
Date: Tue, 27 Mar 2018 18:15:31 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Is there something wrong about the commit log of tools/nextid ?
Message-ID: <20180327101531.GL4684@dhcp12-143.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

Recently I always find this message when I do:

# git status
On branch master                               
Your branch is up-to-date with 'origin/master'.                                                

Changes not staged for commit:                 
  (use "git add <file>..." to update what will be committed)                                   
  (use "git checkout -- <file>..." to discard changes in working directory)                    

        typechange: tools/nextid

Even git pull to latest commit, this problem is still there.
If I did `git blame tools/nextid`, I can't see the commit message
about this file. If I did `git checkout -- tools/nextid`, then
`git blame tools/nextid` shows:

  208422233 (Darrick J. Wong 2015-12-21 18:07:52 +1100 1) sort-group

Only this one line. I don't know what happened to this file, is there
something wrong when merge or push it?

Thanks,
Zorro
