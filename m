Received: from mx1.redhat.com ([209.132.183.28]:38790 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948AbcGADFk (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 30 Jun 2016 23:05:40 -0400
Date: Fri, 1 Jul 2016 11:05:37 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] xfstests: update xfs/096 for new behaviour
Message-ID: <20160701030537.GO23649@eguan.usersys.redhat.com>
References: <1464858659-610-1-git-send-email-jtulak@redhat.com>
 <1467195535-32147-1-git-send-email-jtulak@redhat.com>
 <20160630065459.GW23649@eguan.usersys.redhat.com>
 <20160701003700.GU27480@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160701003700.GU27480@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 01, 2016 at 10:37:00AM +1000, Dave Chinner wrote:
> On Thu, Jun 30, 2016 at 02:54:59PM +0800, Eryu Guan wrote:
> > On Wed, Jun 29, 2016 at 12:18:55PM +0200, Jan Tulak wrote:
> > > Because we recently changed how mkfs behaves when it gets incorrect/invalid
> > > values, update the expected output to reflect the current status.
> > > However, keep also compatibility with the old version.
> > > 
> > > Signed-off-by: Jan Tulak <jtulak@redhat.com>
> > > ---
> > > CHANGE: added compatibility for the old xfsprogs.
> > 
> > Sorry for the late response, because I was lost on this :)
> > 
> > Hi Dave - what's the rule/policy of maintaining the backword
> > compatibility in fstests?
> 
> We try to ensure that tests that work/pass on old versions of
> utilities continue to do so, even as the newer code changes. If the
> new code changes too much, then we can either stop running the test
> on older code, or we fork the test for the new code....

Thanks Dave for the clarification!

> 
> > I know that efforts have been made to make
> > sure new changes don't break old binaries, but is that a must or a
> > best-to-have? And what do you think about the xfsprogs version
> > comparing? (I'm OK with it :-))
> 
> We've tried to avoid using version numbers for comparisons, because
> that becomes a downward spiral into a mess. Instead, we have
> gone down the path of testing for supported features in binaries and
> filesystems, not checking version numbers. i.e. we don't care about
> the version number - we care about the feature that the binary
> provides. Those checks are self documenting - the test tells use
> what it requires which something that version number checks do not
> explain at all.

Makes sense.

> 
> In this case, we have a change in a binary that turns warnings into
> errors or issues errors rather than silently ignores what the user
> asked for and uses defaults. We already filter out anything relevant
> from the result to support all the changes in binary output since
> the test was introduced, so we really can't tell if the value
> substitution behaviour has changed anymore. IOWs, this test really
> isn't serving much purpose as a regression test anymore.
> 
> From that perspective, I'd say we either remove it or we stop trying
> to update it further by adding a new requires check for an old mkfs
> binary that silently accepts invalid log stripe unit sizes. i.e.
> don't add version number checks, add a feature check so that it only
> runs on old mkfs binaries but not new ones. e.g.
> _require_mkfs_accept_invalid_log_sunit()

This looks good to me.

Hi Jan - Can you please send an updated version as Dave suggested above?
And I think the input-validation test could be updated as well to make
it only run on newer mkfs.

Thanks a lot!

Eryu
