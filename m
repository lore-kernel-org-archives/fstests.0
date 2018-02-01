Received: from mail-yw0-f172.google.com ([209.85.161.172]:35994 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbeBAGuX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 1 Feb 2018 01:50:23 -0500
MIME-Version: 1.0
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Feb 2018 08:50:21 +0200
Message-ID: <CAOQ4uxi+L6Bhs_=aTvNemC9wBXHw0_bwwPixNzFcJoc8e79XsQ@mail.gmail.com>
Subject: [LSF/MM TOPIC] Filesystem performance regression tests
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: lsf-pc@lists.linux-foundation.org
Cc: Josef Bacik <jbacik@fb.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, fstests <fstests@vger.kernel.org>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Josef and all,

I would like to be rude and solicit a talk from Josef on automated
performance regression testing (if he is planning to attend).
We know the guys at facebook are running some performance
regression tests for a while and Josef has just upstreamed
a nice taste on this infrastructure to xfstests:
https://marc.info/?l=fstests&m=150765617921864&w=2

But this is only the beginning... for community performance
regression tests to be useful there need to be not only people
running the tests, but also people running the tests on well known
machines and/or well known hardware configurations and maintain
long lived performance results db for those machines.

How can we utilize community resources to achieve that?
Can running performance regressions of gce-xfstests provide
anything close to stable results?

If performance regressions are integrated into 0-day kernel test
robot, that could be extremely beneficial to the community, but can
the robot guaranty to run the tests on dedicated machines or
VMs with dedicated resources?

Do we know of good examples to follow from automated regression
tests done for specific filesystem (Dave Chinner has referred to his
regression tests in one or two occasions)? for other kernel subsystems?

Putting up a regression test server for overlayfs is on my TODO list.
In the mean while, I have little to contribute from my experience, but
would love to sit in that talk.

Cheers,
Amir.
