Received: from mail-pl0-f65.google.com ([209.85.160.65]:39032 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbeFHGRw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Jun 2018 02:17:52 -0400
Received: by mail-pl0-f65.google.com with SMTP id f1-v6so7664959plt.6
        for <fstests@vger.kernel.org>; Thu, 07 Jun 2018 23:17:52 -0700 (PDT)
Date: Fri, 8 Jun 2018 14:17:45 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [RFC PATCH 0/2] fstests: boiler plate reductions
Message-ID: <20180608061745.GD1103@desktop>
References: <20180529004752.8243-1-david@fromorbit.com>
 <20180603135107.GK6581@desktop>
 <20180604025035.GC10972@dastard>
 <20180604030047.GE10972@dastard>
 <20180607053023.GA2861@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607053023.GA2861@desktop>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Dave,

On Thu, Jun 07, 2018 at 01:30:23PM +0800, Eryu Guan wrote:
> On Mon, Jun 04, 2018 at 01:00:47PM +1000, Dave Chinner wrote:
> > On Mon, Jun 04, 2018 at 12:50:36PM +1000, Dave Chinner wrote:
> > > On Sun, Jun 03, 2018 at 09:51:07PM +0800, Eryu Guan wrote:
> > > > On Tue, May 29, 2018 at 10:47:50AM +1000, Dave Chinner wrote:
> > > > > Most (possibly all?) of the code under tests/ has GPL license blurbs
> > > > > - they'll all get converted by this same process. It's a bit murkier
> > > > > when it comes to src/ and ltp/, as this code has varied history. For
> > > > > these directories, the first pass I make will for code that has
> > > > > explicit GPL licenses. Every other file will need to be looked at
> > > > > on a case by case basis and done as time permits...
> > > > > 
> > > > > Please note that I'm not trying to change the license on any of the
> > > > > code, just change the way it is documented to reduce boilerplate
> > > > > code. If I've made any changes that modify the license of any
> > > > > specific code, then I've made a mistake and I need to fix that.
> > > > > Please point out anywhere you think my actions have not been clear
> > > > > and obvious.
> > > > > 
> > > > > Once we have some consensus on how we want to proceed, I'll do the
> > > > > grunt work and co-ordinate with Eryu on minimising the number of
> > > > > times I have to rebase a patchset that is going to touch around 1500
> > > > > files...
> > > > 
> > > > How would you like to proceed with a minimum number of rebasing times? I
> > > > think that most rebase work would come from new tests that being added
> > > > during the whole process, I think I could do
> > > > 
> > > > 1) simply suspend adding new tests until the whole work is done, or
> > > > 2) convert new tests myself if there're just a few of them
> > > 
> > > Easiest thing to do would be for me to convert the tree immediately
> > > before you send out an update. e.g. do your update, send me a note,
> > > I'll run the conversion scripts and send you a pull request based on
> > > the tree you've finished updating....
> 
> I'll push new updates to my github tree and send you the repo address
> and branch name. Hopefully I'll get it done on Friday afternoon so the
> conversion won't take your weekend time.

I've put the updates in my github tree, please get it from

	https://github.com/guaneryu/xfstests.git for-dave

Thanks,
Eryu

> 
> > 
> > That said - this works for the licensing changes, because that's
> > easily scripted. The setup template stuff is going to be a longer
> > process because it's not so easily scripted. Let's get the license
> > change sorted first, then I'll worry about the setup template
> > updates...
> 
> Sounds good, thanks!
> 
> Eryu
